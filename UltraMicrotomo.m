classdef UltraMicrotomo < handle
    properties
        % Informações do sistema
        Operador char = 'Altiort'
        DataHoraInicio datetime = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss')
        
        % Propriedades básicas do equipamento
        Nome char = 'Ultramicrótomo'
        CustoAquisicao double = 0
        VidaUtil double = 0
        CustoManutencao double = 0
        
        % Propriedades para Ne (Neônio)
        CustoNeonio double = 0
        ConsumoNeonio double = 0
        
        % Propriedades para N₂(l) (Nitrogênio líquido)
        CustoNitrogenio double = 0
        ConsumoNitrogenio double = 0
        
        % Propriedades para grades
        CustoGradeCu double = 0          % Grades de Cu (Cobre)
        CustoGradeInox double = 0        % Grades de Fe-Cr-Ni (Liga de Aço Inoxidável)
        QuantidadeGrades double = 0
        
        % Propriedades de tempo
        TempoPreparoHora double = 0
        TempoCorteHora double = 0
        
        % Propriedades de status
        Status logical = false
        DataUltimaManutencao datetime = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss')
        HorasUso double = 0
    end
    
    methods
        function obj = UltraMicrotomo()
            % Construtor
            obj.Nome = 'Ultramicrótomo';
            obj.CustoAquisicao = 0;
            obj.VidaUtil = 0;
            obj.CustoManutencao = 0;
            obj.Status = false;
            obj.Operador = 'Altiort';
            obj.DataHoraInicio = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
            obj.DataUltimaManutencao = datetime('2025-02-21 21:28:51', 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
        end
        
        function custo = calcularCusto(obj, usaGradesCu)
            % Calcula custo do Ne (Neônio)
            custoNeonio = obj.CustoNeonio * obj.ConsumoNeonio;
            
            % Calcula custo do N₂(l) (Nitrogênio líquido)
            custoNitrogenio = obj.CustoNitrogenio * obj.ConsumoNitrogenio;
            
            % Calcula custo das grades
            if usaGradesCu
                custoGrades = obj.CustoGradeCu * obj.QuantidadeGrades;
            else
                custoGrades = obj.CustoGradeInox * obj.QuantidadeGrades;
            end
            
            % Calcula custo de manutenção por hora
            custoManutencaoHora = obj.CustoManutencao * (obj.TempoPreparoHora + obj.TempoCorteHora);
            
            % Custo total
            custo = custoNeonio + custoNitrogenio + custoGrades + custoManutencaoHora;
        end
        
        function atualizarStatus(obj, novoStatus)
            obj.Status = novoStatus;
            if novoStatus
                obj.DataUltimaManutencao = datetime('now');
            end
        end
        
        function registrarUso(obj, horasAdicionais)
            obj.HorasUso = obj.HorasUso + horasAdicionais;
            obj.TempoPreparoHora = horasAdicionais * 0.3; % 30% do tempo para preparo
            obj.TempoCorteHora = horasAdicionais * 0.7;   % 70% do tempo para corte
        end
    end
end