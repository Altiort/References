classdef CalculadoraCustos < handle
    properties (Access = private)
        % Valores de referência do mercado nacional
        ValoresReferencia
    end
    
    methods
        function obj = CalculadoraCustos()
            % Construtor que inicializa a estrutura de valores
            obj.ValoresReferencia = struct();
            obj.ValoresReferencia.HoraHomem = 150.0;            % R$ por hora
            obj.ValoresReferencia.BolsaIC = 700.0;             % R$ por mês
            obj.ValoresReferencia.BolsaMestrado = 1500.0;      % R$ por mês
            obj.ValoresReferencia.BolsaDoutorado = 2200.0;     % R$ por mês
            obj.ValoresReferencia.EnergiaKwh = 0.85;           % R$ por kWh
            obj.ValoresReferencia.AguaM3 = 15.0;               % R$ por m³
            obj.ValoresReferencia.NitrogenioL = 12.0;          % R$ por L de N₂(l) (Nitrogênio Líquido)
            obj.ValoresReferencia.ArgonioL = 45.0;             % R$ por L de Ar (Argônio)
            obj.ValoresReferencia.HelioL = 120.0;              % R$ por L de He (Hélio)
            obj.ValoresReferencia.OxigenioL = 30.0;            % R$ por L de O₂ (Oxigênio)
            obj.ValoresReferencia.GradeCu = 25.0;              % R$ por unidade de Cu (Cobre)
            obj.ValoresReferencia.GradeAu = 45.0;              % R$ por unidade de Au (Ouro)
            obj.ValoresReferencia.FilmeCarbono = 15.0;         % R$ por unidade de C (Carbono)
            obj.ValoresReferencia.ResinaEpoxi = 250.0;         % R$ por kg
            obj.ValoresReferencia.CrioKit = 500.0;             % R$ por kit criogênico
            obj.ValoresReferencia.InternetMensal = 200.0;      % R$ por mês
            obj.ValoresReferencia.ValorSTEM = 5000000.0;       % R$ equipamento
            obj.ValoresReferencia.ValorUTM = 800000.0;         % R$ equipamento
            obj.ValoresReferencia.ValorEdificacao = 2000000.0; % R$ infraestrutura
            obj.ValoresReferencia.FerramentasUTM = 25000.0;    % R$ conjunto
            obj.ValoresReferencia.FiltroAgua = 1200.0;         % R$ unidade H₂O(l) (Água)
            obj.ValoresReferencia.FiltroCriogenico = 2500.0;   % R$ unidade N₂(l) (Nitrogênio Líquido)
            obj.ValoresReferencia.GradeInox = 35.0;            % R$ unidade Fe-Cr-Ni (Liga de Aço Inoxidável)
            obj.ValoresReferencia.VidaUtilSTEM = 120;          % meses
            obj.ValoresReferencia.VidaUtilUTM = 60;            % meses
            obj.ValoresReferencia.VidaUtilEdificacao = 300;    % meses
        end
        
        % [Resto dos métodos permanece igual...]
    end
end