// app/cadastro/page.js
'use client'; // Necessário no Next.js para usar eventos como onClick e useState

import { useState } from 'react';

export default function CadastroEstudante() {
  const [formData, setFormData] = useState({
    nome: '',
    email_institucional: '',
    senha: '',
    curso: '',
    telefone: ''
  });
  const [statusMsg, setStatusMsg] = useState('');

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setStatusMsg('Salvando...');

    try {
      // Chama a nossa rota de API criada no passo 1
      const response = await fetch('/api/estudantes', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      if (response.ok) {
        setStatusMsg('Sucesso! O estudante foi cadastrado.');
        setFormData({ nome: '', email_institucional: '', senha: '', curso: '', telefone: '' }); // Limpa o form
      } else {
        setStatusMsg(`Erro: ${data.error}`);
      }
    } catch (error) {
      setStatusMsg('Erro de conexão com o servidor.');
    }
  };

  return (
    <div style={{ maxWidth: '400px', margin: '50px auto', fontFamily: 'sans-serif' }}>
      <h2>Cadastro de Estudante</h2>
      <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '15px' }}>
        
        <input type="text" name="nome" placeholder="Nome Completo" value={formData.nome} onChange={handleChange} required />
        <input type="email" name="email_institucional" placeholder="E-mail da UnB" value={formData.email_institucional} onChange={handleChange} required />
        <input type="password" name="senha" placeholder="Senha" value={formData.senha} onChange={handleChange} required />
        <input type="text" name="curso" placeholder="Nome do Curso" value={formData.curso} onChange={handleChange} required />
        <input type="text" name="telefone" placeholder="Telefone (DDD + Número)" value={formData.telefone} onChange={handleChange} required />
        
        <button type="submit" style={{ padding: '10px', cursor: 'pointer' }}>Cadastrar</button>
      </form>
      
      {statusMsg && <p>{statusMsg}</p>}
    </div>
  );
}