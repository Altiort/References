classdef LabMicroscopiaApp < matlab.apps.AppBase
    properties (Access = private)
        % Componentes principais da UI usando o padrão moderno
        UIFigure            matlab.ui.Figure
        MainGrid           matlab.ui.container.GridLayout
        
        % Componentes do Menu
        MenuBar            matlab.ui.container.Menu
        AnaliseMenu        matlab.ui.container.Menu
        TEMMenu            matlab.ui.container.Menu
        % RAMANMenu          matlab.ui.container.Menu  % Comentado conforme solicitado
        EDSMenu            matlab.ui.container.Menu
        DRXMenu            matlab.ui.container.Menu
        CrioMenu          matlab.ui.container.Menu
        AjudaMenu          matlab.ui.container.Menu
        SobreMenu         matlab.ui.container.Menu
        
        % Propriedades para controle de versão e data
        Version     = '1.0'
        UpdateDate  = '2024-02'
    end
 
    methods (Access = private)
        function abrirAnaliseTEM(app, tipo)
    try
        % Criação de nova análise TEM com suporte a:
        % N₂(l) (Nitrogênio Líquido)
        % H₂O (Água)
        % Cu (Grades de Cobre)
        novaAnalise = AnaliseTemApp(tipo);
    catch ex
        msgbox(sprintf('Erro ao abrir análise TEM: %s', ex.message), 'Erro', 'error');
    end
end
        
        % Função RAMAN comentada conforme solicitado
        % function abrirAnaliseRAMAN(app)
        %     try
        %         novaAnalise = AnaliseRamanApp('RAMAN Padrão');
        %     catch ex
        %         msgbox(sprintf('Erro ao abrir análise RAMAN: %s', ex.message), 'Erro', 'error');
        %     end
        % end
        
        function abrirAnaliseEDS(app)
            try
                msgbox(['Análise EDS (Espectroscopia por Dispersão em Energia) em desenvolvimento\n', ...
                       'Suporte planejado para análise multi-elementar'], 'Informação', 'help');
            catch ex
                msgbox(sprintf('Erro ao abrir análise EDS: %s', ex.message), 'Erro', 'error');
            end
        end
        
        function abrirAnaliseDRX(app)
            try
                msgbox(['Análise DRX (Difração de Raios X) em desenvolvimento\n', ...
                       'Suporte planejado para análise de fases cristalinas'], 'Informação', 'help');
            catch ex
                msgbox(sprintf('Erro ao abrir análise DRX: %s', ex.message), 'Erro', 'error');
            end
        end

        % Callbacks dos menus atualizados para o padrão moderno
        function TEMMenuSelected(app, ~)
            abrirAnaliseTEM(app, 'TEM Padrão');
        end
        
        function CriogenicoMenuSelected(app, ~)
            abrirAnaliseTEM(app, 'TEM Criogênico');
        end

        % Callback RAMAN comentado conforme solicitado
        % function RAMANMenuSelected(app, ~)
        %     try
        %         novaAnalise = AnaliseRamanApp('RAMAN Padrão');
        %     catch ex
        %         msgbox(sprintf('Erro ao abrir análise RAMAN: %s', ex.message), 'Erro', 'error');
        %     end
        % end
        
        function EDSMenuSelected(app, ~)
            abrirAnaliseEDS(app);
        end
        
        function DRXMenuSelected(app, ~)
            abrirAnaliseDRX(app);
        end
        
        function SobreMenuSelected(app, ~)
            msg = sprintf(['Sistema de Análise de Custos - Laboratório de Microscopia\n\n', ...
                'Versão: %s\n', ...
                'Desenvolvido por: %s\n', ...
                'Data: %s\n\n', ...
                'Técnicas Disponíveis:\n', ...
                '- TEM (Microscopia Eletrônica de Transmissão)\n', ...
                '- EDS (Espectroscopia por Dispersão em Energia)\n', ...
                '- DRX (Difração de Raios X)\n\n', ...
                'Compostos e Reagentes Utilizados:\n', ...
                '- N₂(l) (Nitrogênio Líquido)\n', ...
                '- H₂O (Água)\n', ...
                '- Cu (Grades de Cobre)\n', ...
                '- Al₂O₃ (Óxido de Alumínio)\n', ...
                '- SiO₂ (Dióxido de Silício)\n'], ...
                app.Version, 'Altiort', app.UpdateDate);
            msgbox(msg, 'Sobre o Sistema', 'help');
        end
          
        function createComponents(app)
            % Criar a janela principal usando o padrão moderno
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 800 700];
            app.UIFigure.Name = 'Laboratório de Microscopia - Sistema de Análise de Custos';
            app.UIFigure.WindowStyle = 'normal';
            
            % Grid layout principal atualizado
            app.MainGrid = uigridlayout(app.UIFigure, [3 1]);
            app.MainGrid.RowHeight = {'fit', '1x', 'fit'};
            app.MainGrid.Padding = [20 20 20 20];
            app.MainGrid.RowSpacing = 20;
            
            % Barra de menu atualizada
            app.MenuBar = uimenu(app.UIFigure, 'Text', 'Menu');
            app.AnaliseMenu = uimenu(app.MenuBar, 'Text', 'Análises');
            
            % Menu TEM atualizado
            app.TEMMenu = uimenu(app.AnaliseMenu, 'Text', ...
                'TEM (Microscopia Eletrônica de Transmissão) - N₂(l), Cu, H₂O');
            
            uimenu(app.TEMMenu, 'Text', 'Análise Padrão', ...
                'MenuSelectedFcn', @(~,~) app.TEMMenuSelected);
            
            uimenu(app.TEMMenu, 'Text', 'Análise Criogênica', ...
                'MenuSelectedFcn', @(~,~) app.CriogenicoMenuSelected);
            
            % Outros menus atualizados
            app.EDSMenu = uimenu(app.AnaliseMenu, 'Text', ...
                'EDS (Espectroscopia por Dispersão em Energia)', ...
                'MenuSelectedFcn', @(~,~) app.EDSMenuSelected);
            
            app.DRXMenu = uimenu(app.AnaliseMenu, 'Text', ...
                'DRX (Difração de Raios X)', ...
                'MenuSelectedFcn', @(~,~) app.DRXMenuSelected);
            
            % Menu Ajuda atualizado
            app.AjudaMenu = uimenu(app.MenuBar, 'Text', 'Ajuda');
            app.SobreMenu = uimenu(app.AjudaMenu, 'Text', 'Sobre', ...
                'MenuSelectedFcn', @(~,~) app.SobreMenuSelected);
            
            % Cabeçalho atualizado com o padrão moderno
            bemVindoLabel = uilabel(app.MainGrid);
            bemVindoLabel.Text = sprintf(['Bem-vindo ao Sistema de Análise de Custos\n', ...
                'Laboratório de Microscopia\n\n', ...
                'Selecione uma análise no menu superior\n\n', ...
                'Principais Compostos: N₂(l) (Nitrogênio Líquido), ', ...
                'Cu (Grades de Cobre), H₂O (Água)']);
            bemVindoLabel.HorizontalAlignment = 'center';
            bemVindoLabel.FontSize = 16;
            bemVindoLabel.FontWeight = 'bold';
            bemVindoLabel.Layout.Row = 1;
            
            % Tornar a interface visível
            app.UIFigure.Visible = 'on';
        end
    end    
      
    methods (Access = public)
        function app = LabMicroscopiaApp
            try
                app.Version = '1.0';
                app.UpdateDate = '2025-02-24'; % Data fixa para controle de versão
                createComponents(app);
                
                % Registro de uso atualizado
                disp(['Aplicativo iniciado por: ', 'Altiort']);
                disp(['Data e hora de início: ', datestr(now, 'yyyy-mm-dd HH:MM:SS')]);
                
            catch ex
                delete(app);
                rethrow(ex);
            end
        end
        
        function delete(app)
            if isvalid(app.UIFigure)
                delete(app.UIFigure);
            end
        end
    end
end