classdef AnaliseRaman < matlab.apps.AppBase
    properties (Access = public)
        % Informações básicas
        Operador char = 'Altiort'
        DataHoraInicio datetime = datetime('2025-02-21 21:51:53', 'InputFormat', 'yyyy-MM-dd HH:mm:ss')
        
        % Interface principal
        UIFigure            matlab.ui.Figure
        MainGrid            matlab.ui.container.GridLayout
        
        % Painéis
        LaserPanel          matlab.ui.container.Panel
        FiltrosPanel        matlab.ui.container.Panel
        ResultadosPanel     matlab.ui.container.Panel
        
        % Labels informativos
        OperadorLabel       matlab.ui.control.Label
        DataHoraLabel       matlab.ui.control.Label
        
        % Campos de entrada para laser
        LaserEdit           matlab.ui.control.NumericEditField
        PotenciaEdit        matlab.ui.control.NumericEditField
        
        % Campos de entrada para filtros
        FiltroRayleighEdit  matlab.ui.control.NumericEditField
        FiltroNotchEdit     matlab.ui.control.NumericEditField
        
        % Campo para resultado
        CustoTotalLabel     matlab.ui.control.Label
    end
    
    methods (Access = private)
        function inicializarComponentes(app)
            % Criar janela principal
            app.UIFigure = uifigure('Name', 'Análise de Custos - Raman');
            app.UIFigure.Position = [200 200 800 600];
            
            % Grid layout principal
            app.MainGrid = uigridlayout(app.UIFigure, [4 2]);
            app.MainGrid.RowHeight = {'auto', '1x', '1x', 'auto'};
            app.MainGrid.ColumnWidth = {'1x', '1x'};
            app.MainGrid.Padding = [10 10 10 10];
            
            % Labels informativos
            app.OperadorLabel = uilabel(app.MainGrid);
            app.OperadorLabel.Text = ['Operador: ' app.Operador];
            app.OperadorLabel.Layout.Row = 1;
            app.OperadorLabel.Layout.Column = 1;
            
            app.DataHoraLabel = uilabel(app.MainGrid);
            app.DataHoraLabel.Text = ['Data/Hora: ' char(app.DataHoraInicio)];
            app.DataHoraLabel.Layout.Row = 1;
            app.DataHoraLabel.Layout.Column = 2;
            
            % Painel do Laser
            app.LaserPanel = uipanel(app.MainGrid);
            app.LaserPanel.Title = 'Configuração do Laser';
            app.LaserPanel.Layout.Row = 2;
            app.LaserPanel.Layout.Column = [1 2];
            
            laserGrid = uigridlayout(app.LaserPanel, [2 2]);
            
            % Campos para Laser
            uilabel(laserGrid, 'Text', 'Custo do Laser (R$)');
            app.LaserEdit = uieditfield(laserGrid, 'numeric');
            
            uilabel(laserGrid, 'Text', 'Potência (mW)');
            app.PotenciaEdit = uieditfield(laserGrid, 'numeric');
            
            % Painel de Filtros
            app.FiltrosPanel = uipanel(app.MainGrid);
            app.FiltrosPanel.Title = 'Filtros';
            app.FiltrosPanel.Layout.Row = 3;
            app.FiltrosPanel.Layout.Column = [1 2];
            
            filtrosGrid = uigridlayout(app.FiltrosPanel, [2 2]);
            
            % Campos para Filtros
            uilabel(filtrosGrid, 'Text', 'Filtro Rayleigh (R$)');
            app.FiltroRayleighEdit = uieditfield(filtrosGrid, 'numeric');
            
            uilabel(filtrosGrid, 'Text', 'Filtro Notch (R$)');
            app.FiltroNotchEdit = uieditfield(filtrosGrid, 'numeric');
            
            % Resultado
            app.CustoTotalLabel = uilabel(app.MainGrid);
            app.CustoTotalLabel.Text = 'Custo Total: R$ 0,00';
            app.CustoTotalLabel.Layout.Row = 4;
            app.CustoTotalLabel.Layout.Column = [1 2];
            app.CustoTotalLabel.HorizontalAlignment = 'center';
            app.CustoTotalLabel.FontSize = 16;
            app.CustoTotalLabel.FontWeight = 'bold';
            
            % Adicionar listeners para atualização automática
            addlistener(app.LaserEdit, 'ValueChanged', @(~,~) calcularCustoTotal(app));
            addlistener(app.PotenciaEdit, 'ValueChanged', @(~,~) calcularCustoTotal(app));
            addlistener(app.FiltroRayleighEdit, 'ValueChanged', @(~,~) calcularCustoTotal(app));
            addlistener(app.FiltroNotchEdit, 'ValueChanged', @(~,~) calcularCustoTotal(app));
        end
        
        function calcularCustoTotal(app)
            try
                % Obter valores dos campos
                custoLaser = app.LaserEdit.Value;
                potencia = app.PotenciaEdit.Value;
                custoRayleigh = app.FiltroRayleighEdit.Value;
                custoNotch = app.FiltroNotchEdit.Value;
                
                % Calcular custo total
                custoTotal = (custoLaser * (potencia/1000)) + custoRayleigh + custoNotch;
                
                % Atualizar label
                app.CustoTotalLabel.Text = sprintf('Custo Total: R$ %.2f', custoTotal);
            catch ex
                msgbox(['Erro no cálculo: ' ex.message], 'Erro', 'error');
            end
        end
    end
    
    methods (Access = public)
        function app = AnaliseRaman(tipo)
            try
                inicializarComponentes(app);
                app.UIFigure.Visible = 'on';
            catch ex
                delete(app);
                rethrow(ex);
            end
        end
    end
end