classdef LabMicroscopiaApp < matlab.apps.AppBase
    properties (Access = private)
        % Componentes principais da UI
        UIFigure            matlab.ui.Figure
        ScrollPanel         matlab.ui.container.Panel  % Novo componente para rolagem
        MainGrid           matlab.ui.container.GridLayout
        
        % Componentes do Menu
        MenuBar            matlab.ui.container.Menu
        AnaliseMenu        matlab.ui.container.Menu
        TEMMenu            matlab.ui.container.Menu
        RAMANMenu          matlab.ui.container.Menu
        EDSMenu            matlab.ui.container.Menu
        DRXMenu            matlab.ui.container.Menu
        CrioMenu           matlab.ui.container.Menu
        AjudaMenu          matlab.ui.container.Menu
        SobreMenu          matlab.ui.container.Menu
        
        % Propriedades para controle de versão e data
        Version     = '1.0'
        UpdateDate  = '2024-02'
    end
 
    methods (Access = private)
        function abrirAnaliseTEM(app, tipo)
            try
                % Criação de nova análise TEM com suporte a N₂(l) (Nitrogênio Líquido),
                % H₂O (Água) e Cu (Grades de Cobre)
                novaAnalise = AnaliseTemApp(tipo);
            catch ex
                msgbox(sprintf('Erro ao abrir análise TEM: %s', ex.message), 'Erro', 'error');
            end
        end
        
        function abrirAnaliseRAMAN(app)
            try
                % Sistema RAMAN com suporte a análise de compostos orgânicos e inorgânicos
                novaAnalise = AnaliseRamanApp('RAMAN Padrão');
            catch ex
                msgbox(sprintf('Erro ao abrir análise RAMAN: %s', ex.message), 'Erro', 'error');
            end
        end
        
        function abrirAnaliseEDS(app)
            try
                % Análise de composição elementar por EDS
                msgbox(['Análise EDS (Espectroscopia por Dispersão em Energia) em desenvolvimento\n', ...
                       'Suporte planejado para análise multi-elementar'], 'Informação', 'help');
            catch ex
                msgbox(sprintf('Erro ao abrir análise EDS: %s', ex.message), 'Erro', 'error');
            end
        end
        
        function abrirAnaliseDRX(app)
            try
                % Análise de estrutura cristalina por DRX
                msgbox(['Análise DRX (Difração de Raios X) em desenvolvimento\n', ...
                       'Suporte planejado para análise de fases cristalinas'], 'Informação', 'help');
            catch ex
                msgbox(sprintf('Erro ao abrir análise DRX: %s', ex.message), 'Erro', 'error');
            end
        end

        % Callbacks dos menus
        function TEMMenuSelected(app, ~)
            % Menu para Microscopia Eletrônica de Transmissão padrão
            abrirAnaliseTEM(app, 'TEM Padrão');
        end
        
        function CriogenicoMenuSelected(app, ~)
            % Menu para Microscopia Eletrônica de Transmissão em condições criogênicas
            % Utiliza N₂(l) (Nitrogênio Líquido) para resfriamento
            abrirAnaliseTEM(app, 'TEM Criogênico');
        end

        function RAMANMenuSelected(app, ~)
            try
                % Menu para Espectroscopia Raman
                novaAnalise = AnaliseRamanApp('RAMAN Padrão');
            catch ex
                msgbox(sprintf('Erro ao abrir análise RAMAN: %s', ex.message), 'Erro', 'error');
            end
        end
        
        function EDSMenuSelected(app, ~)
            % Menu para Espectroscopia por Dispersão em Energia
            abrirAnaliseEDS(app);
        end
        
        function DRXMenuSelected(app, ~)
            % Menu para Difração de Raios X
            abrirAnaliseDRX(app);
        end
        
        function SobreMenuSelected(app, ~)
            msg = sprintf(['Sistema de Análise de Custos - Laboratório de Microscopia\n\n', ...
                'Versão: %s\n', ...
                'Desenvolvido por: %s\n', ...
                'Data: %s\n\n', ...
                'Técnicas Disponíveis:\n', ...
                '- TEM (Microscopia Eletrônica de Transmissão)\n', ...
                '- RAMAN (Espectroscopia Raman)\n', ...
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
            % Criar a janela principal com suporte a rolagem
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1024 768];
            app.UIFigure.Name = 'Laboratório de Microscopia - Sistema de Análise de Custos';
            app.UIFigure.WindowStyle = 'normal';
            app.UIFigure.Resize = 'on';
            
            % Criar painel com rolagem
            app.ScrollPanel = uipanel(app.UIFigure);
            app.ScrollPanel.Position = [0 0 1024 768];
            app.ScrollPanel.Units = 'normalized';
            app.ScrollPanel.Position = [0 0 1 1];
            app.ScrollPanel.Scrollable = 'on';
            
            % Criar barra de menu
            app.MenuBar = uimenu(app.UIFigure, 'Text', 'Menu');
            
            % Menu Análises com técnicas e compostos
            app.AnaliseMenu = uimenu(app.MenuBar, 'Text', 'Análises');
            
            % Submenu TEM com informações sobre compostos
            app.TEMMenu = uimenu(app.AnaliseMenu, 'Text', ...
                'TEM (Microscopia Eletrônica de Transmissão) - N₂(l), Cu, H₂O');
            
            % Menu de análise padrão
            uimenu(app.TEMMenu, 'Text', 'Análise Padrão', ...
                'MenuSelectedFcn', @(~,~) app.TEMMenuSelected);
            
            % Menu de análise criogênica
            uimenu(app.TEMMenu, 'Text', 'Análise Criogênica', ...
                'MenuSelectedFcn', @(~,~) app.CriogenicoMenuSelected);
            
            % Outros menus de análise com suas especificidades
            app.RAMANMenu = uimenu(app.AnaliseMenu, 'Text', ...
                'RAMAN (Espectroscopia Raman)', ...
                'MenuSelectedFcn', @(~,~) app.RAMANMenuSelected);
            
            app.EDSMenu = uimenu(app.AnaliseMenu, 'Text', ...
                'EDS (Espectroscopia por Dispersão em Energia)', ...
                'MenuSelectedFcn', @(~,~) app.EDSMenuSelected);
            
            app.DRXMenu = uimenu(app.AnaliseMenu, 'Text', ...
                'DRX (Difração de Raios X)', ...
                'MenuSelectedFcn', @(~,~) app.DRXMenuSelected);
            
            % Menu Ajuda
            app.AjudaMenu = uimenu(app.MenuBar, 'Text', 'Ajuda');
            app.SobreMenu = uimenu(app.AjudaMenu, 'Text', 'Sobre', ...
                'MenuSelectedFcn', @(~,~) app.SobreMenuSelected);
            
            % Grid principal dentro do painel rolável
            app.MainGrid = uigridlayout(app.ScrollPanel, [2 1]);
            app.MainGrid.Padding = [20 20 20 20];
            app.MainGrid.RowHeight = {'1x', '4x'};
            
            % Criar cabeçalho com logo ou mensagem de boas-vindas
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
                % Inicialização do aplicativo com data e usuário atuais
                app.Version = '1.0';
                app.UpdateDate = '2025-02-22'; % Data atual
                
                % Criar componentes com suporte a fórmulas químicas:
                % - N₂(l) (Nitrogênio Líquido)
                % - H₂O (Água)
                % - Cu (Grades de Cobre)
                % - Al₂O₃ (Óxido de Alumínio)
                % - SiO₂ (Dióxido de Silício)
                createComponents(app);
                
                % Registrar informações de uso
                disp(['Aplicativo iniciado por: ', 'Altiort']);
                disp(['Data e hora de início: ', '2025-02-22 17:56:10']);
                
            catch ex
                % Em caso de erro, limpar e relançar exceção
                delete(app);
                rethrow(ex);
            end
        end
        
        % Destruidor da classe
        function delete(app)
            % Limpar recursos ao fechar o aplicativo
            if isvalid(app.UIFigure)
                delete(app.UIFigure);
            end
        end
    end
end
 