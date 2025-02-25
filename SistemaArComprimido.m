classdef SistemaArComprimido < handle
    properties
        % Informações do sistema
        Operador char = 'Altiort'
        DataHoraInicio datetime = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss')
        
        % Propriedades básicas
        Nome char = 'Sistema de Ar Comprimido'
        CustoAquisicao double = 0
        VidaUtil double = 0
        
        % Propriedades para H₂O(v) (Vapor de água)
        CustoFiltroAgua double = 0
        FiltroEliminadorAgua logical = false
        
        % Propriedades do sistema
        ConsumoAr double = 0        % em m³/h
        CustoManutencao double = 0  % R$/h
        TempoUsoHora double = 0
        
        % Status do sistema
        Status logical = false
        DataUltimaManutencao datetime = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss')
        HorasUso double = 0
    end
    
    methods
        function obj = SistemaArComprimido()
            % Construtor
            obj.Nome = 'Sistema de Ar Comprimido';
            obj.Status = false;
            obj.Operador = 'Altiort';
            obj.DataHoraInicio = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
            obj.DataUltimaManutencao = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
        end
        
        function custoHora = calcularCustoHora(obj)
            % Cálculo do custo por hora de operação
            custoFiltros = obj.CustoFiltroAgua;  % Custo do filtro H₂O(v) (Vapor de água)
            custoOperacao = obj.ConsumoAr * obj.CustoManutencao;
            custoHora = custoFiltros + custoOperacao;
        end
        
        function atualizarTempoUso(obj, tempoTotal)
            % Atualização do tempo de uso
            obj.TempoUsoHora = tempoTotal;
            obj.HorasUso = obj.HorasUso + tempoTotal;
        end
        
        function ativarFiltroAgua(obj)
            % Ativação do filtro de H₂O(v) (Vapor de água)
            obj.FiltroEliminadorAgua = true;
        end
        
        function desativarFiltroAgua(obj)
            % Desativação do filtro de H₂O(v) (Vapor de água)
            obj.FiltroEliminadorAgua = false;
        end
        
        function registrarManutencao(obj)
            % Registro de nova manutenção
            obj.DataUltimaManutencao = datetime('now');
            obj.Status = true;
        end
    end
end