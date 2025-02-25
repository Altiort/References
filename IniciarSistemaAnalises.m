% Script para iniciar o sistema de análises com interface gráfica
function IniciarSistemaAnalises()
    % Limpa workspace e fecha janelas abertas
    clear all;
    close all;
    clc;
    
    try
        % Verifica se todas as classes necessárias estão disponíveis
        if ~exist('LabAnalisesCustosApp', 'class')
            error('Classe LabAnalisesCustosApp não encontrada');
        end
        if ~exist('CalculadoraCustos', 'class')
            error('Classe CalculadoraCustos não encontrada');
        end
        if ~exist('TipoAnalise', 'class')
            error('Classe TipoAnalise não encontrada');
        end
        
        % Inicia a aplicação principal
        fprintf('Iniciando sistema de análise de custos...\n');
        fprintf('Compostos disponíveis para análise:\n');
        fprintf('- N₂(l) (Nitrogênio Líquido)\n');
        fprintf('- H₂O(l) (Água Líquida)\n');
        fprintf('- Fe-Cr-Ni (Liga de Aço Inoxidável)\n');
        fprintf('- Cu (Cobre)\n');
        fprintf('- Au (Ouro)\n');
        fprintf('- C (Carbono)\n');
        
        % Cria e executa a aplicação
        app = LabAnalisesCustosApp();
        
        fprintf('Sistema iniciado com sucesso!\n');
        
    catch err
        % Tratamento de erros
        fprintf('Erro ao iniciar o sistema:\n');
        fprintf('%s\n', err.message);
        return;
    end
end