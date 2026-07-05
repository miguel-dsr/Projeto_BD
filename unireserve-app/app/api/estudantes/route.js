// app/api/estudantes/route.js
import pool from '@/lib/db';
import { NextResponse } from 'next/server';

export async function POST(request) {
  // Pega os dados enviados pelo formulário do front-end
  const { nome, email_institucional, senha, curso, telefone } = await request.json();

  // Puxa uma conexão exclusiva para podermos usar a Transação
  const connection = await pool.getConnection();

  try {
    // Inicia a transação de segurança
    await connection.beginTransaction();

    // 1. Insere na tabela mãe: Usuario
    const [userResult] = await connection.execute(
      'INSERT INTO unireserve.Usuario (nome, email_institucional, senha) VALUES (?, ?, ?)',
      [nome, email_institucional, senha]
    );
    
    // Captura o ID gerado automaticamente pelo AUTO_INCREMENT
    const idUsuario = userResult.insertId;

    // 2. Insere na tabela filha: Estudante (usando o ID capturado)
    await connection.execute(
      'INSERT INTO unireserve.Estudante (id_usuario, curso) VALUES (?, ?)',
      [idUsuario, curso]
    );

    // 3. Insere o atributo multivalorado: Usuario_Telefone
    await connection.execute(
      'INSERT INTO unireserve.Usuario_Telefone (id_usuario, telefone) VALUES (?, ?)',
      [idUsuario, telefone]
    );

    // Se tudo deu certo, confirma (salva de verdade) as alterações no banco
    await connection.commit();

    return NextResponse.json(
      { message: 'Estudante cadastrado com sucesso!', id: idUsuario },
      { status: 201 }
    );

  } catch (error) {
    // Se der qualquer erro (ex: e-mail muito longo, falta de dado), desfaz tudo!
    await connection.rollback();
    return NextResponse.json(
      { error: 'Erro ao cadastrar. A operação foi cancelada.', details: error.message },
      { status: 500 }
    );
  } finally {
    // Devolve a conexão para a piscina (pool) para não travar o servidor
    connection.release();
  }
}