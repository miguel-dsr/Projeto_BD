-- CreateTable
CREATE TABLE `Usuario` (
    `id_usuario` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(60) NOT NULL,
    `email_institucional` VARCHAR(100) NOT NULL,
    `senha` VARCHAR(60) NOT NULL,

    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Estudante` (
    `id_usuario` INTEGER NOT NULL,
    `curso` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Servidor` (
    `id_usuario` INTEGER NOT NULL,
    `cargo` VARCHAR(255) NOT NULL,
    `departamento_vinculo` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Usuario_Telefone` (
    `id_usuario` INTEGER NOT NULL,
    `telefone` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`id_usuario`, `telefone`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Bloco_Predio` (
    `id_bloco` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_bloco` VARCHAR(255) NOT NULL,
    `campus` VARCHAR(255) NOT NULL,
    `horario_abertura` TIME(0) NOT NULL,
    `horario_fechamento` TIME(0) NOT NULL,

    PRIMARY KEY (`id_bloco`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Categoria_Recurso` (
    `id_categoria` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id_categoria`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Recurso_Reservavel` (
    `id_recurso` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,
    `indicador_disponibilidade` CHAR(1) NOT NULL,
    `descricao_regras` VARCHAR(255) NOT NULL,
    `id_bloco` INTEGER NOT NULL,
    `id_categoria` INTEGER NOT NULL,

    PRIMARY KEY (`id_recurso`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Espaco_Fisico` (
    `id_recurso` INTEGER NOT NULL,
    `capacidade` INTEGER NOT NULL,

    PRIMARY KEY (`id_recurso`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Equipamento` (
    `id_recurso` INTEGER NOT NULL,
    `numero_serie` INTEGER NOT NULL,
    `marca_modelo` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id_recurso`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Manutencao` (
    `id_manutencao` INTEGER NOT NULL AUTO_INCREMENT,
    `data` DATE NOT NULL,
    `descricao` VARCHAR(255) NOT NULL,
    `valor` DECIMAL(8, 2) NOT NULL,
    `foto_estado_blob` LONGBLOB NOT NULL,
    `id_recurso` INTEGER NOT NULL,

    PRIMARY KEY (`id_manutencao`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Reserva` (
    `id_reserva` INTEGER NOT NULL AUTO_INCREMENT,
    `data_solicitacao` DATETIME(3) NOT NULL,
    `aceitou_termo_solicitacao` BOOLEAN NOT NULL,
    `TS_aceitacao_termo` TIMESTAMP(0) NOT NULL,
    `data_inicio` DATE NOT NULL,
    `duracao_reserva` TIME(0) NOT NULL,
    `data_devolucao` DATE NOT NULL,
    `id_usuario` INTEGER NOT NULL,

    PRIMARY KEY (`id_reserva`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Reserva_Recurso` (
    `id_reserva` INTEGER NOT NULL,
    `id_recurso` INTEGER NOT NULL,

    PRIMARY KEY (`id_reserva`, `id_recurso`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Estudante` ADD CONSTRAINT `Estudante_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Servidor` ADD CONSTRAINT `Servidor_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Usuario_Telefone` ADD CONSTRAINT `Usuario_Telefone_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Recurso_Reservavel` ADD CONSTRAINT `Recurso_Reservavel_id_bloco_fkey` FOREIGN KEY (`id_bloco`) REFERENCES `Bloco_Predio`(`id_bloco`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Recurso_Reservavel` ADD CONSTRAINT `Recurso_Reservavel_id_categoria_fkey` FOREIGN KEY (`id_categoria`) REFERENCES `Categoria_Recurso`(`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Espaco_Fisico` ADD CONSTRAINT `Espaco_Fisico_id_recurso_fkey` FOREIGN KEY (`id_recurso`) REFERENCES `Recurso_Reservavel`(`id_recurso`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Equipamento` ADD CONSTRAINT `Equipamento_id_recurso_fkey` FOREIGN KEY (`id_recurso`) REFERENCES `Recurso_Reservavel`(`id_recurso`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Manutencao` ADD CONSTRAINT `Manutencao_id_recurso_fkey` FOREIGN KEY (`id_recurso`) REFERENCES `Recurso_Reservavel`(`id_recurso`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reserva` ADD CONSTRAINT `Reserva_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reserva_Recurso` ADD CONSTRAINT `Reserva_Recurso_id_reserva_fkey` FOREIGN KEY (`id_reserva`) REFERENCES `Reserva`(`id_reserva`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reserva_Recurso` ADD CONSTRAINT `Reserva_Recurso_id_recurso_fkey` FOREIGN KEY (`id_recurso`) REFERENCES `Recurso_Reservavel`(`id_recurso`) ON DELETE RESTRICT ON UPDATE CASCADE;
