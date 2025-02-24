
classdef AnaliseTemApp < matlab.apps.AppBase
    properties (Access = private)
        % Interface principal
        UIFigure            matlab.ui.Figure
        ScrollPanel         matlab.ui.container.Panel  % Novo painel com rolagem
        MainGrid           matlab.ui.container.GridLayout
        ResultFigure       matlab.ui.Figure
        
        % Campos para Recursos Humanos
        ValorHoraHomemEdit     matlab.ui.control.NumericEditField
        ConsumoHoraHomemEdit   matlab.ui.control.NumericEditField
        
        % Campos para Insumos
        NitrogenioLiquidoEdit  matlab.ui.control.NumericEditField
        QtdNitrogenioEdit      matlab.ui.control.NumericEditField
        GradesCuEdit          matlab.ui.control.NumericEditField
        QtdGradesEdit         matlab.ui.control.NumericEditField
        PincasEdit            matlab.ui.control.NumericEditField
        QtdPincasEdit         matlab.ui.control.NumericEditField
        
        % Campos para Utilidades
        EnergiaHoraEdit       matlab.ui.control.NumericEditField
        ConsumoEnergiaEdit    matlab.ui.control.NumericEditField
        AguaM3Edit            matlab.ui.control.NumericEditField
        ConsumoAguaEdit       matlab.ui.control.NumericEditField
        
        % Campos para Custos Fixos
        ValorEquipamentoEdit  matlab.ui.control.NumericEditField
        VidaUtilMesesEdit     matlab.ui.control.NumericEditField
        AnalisesMensaisEdit   matlab.ui.control.NumericEditField
        
        ExecutarButton        matlab.ui.control.Button
        ResultadoTextArea     matlab.ui.control.TextArea
        TipoAnalise          string = "TEM"
    end
      
    methods (Access = private)
        function createComponents(app)
            % Criar a janela principal
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 800 800];
            app.UIFigure.Name = ['Análise ' char(app.TipoAnalise) ' - Cálculo de Custos'];
            app.UIFigure.WindowStyle = 'normal';
            app.UIFigure.Resize = 'on';
            
            % Criar painel com rolagem
            app.ScrollPanel = uipanel(app.UIFigure);
            app.ScrollPanel.Position = [0 0 app.UIFigure.Position(3) app.UIFigure.Position(4)];
            app.ScrollPanel.BorderType = 'none';
            
            % Configurar propriedades de rolagem
            s = uistyle('BackgroundColor', [0.95 0.95 0.95]);
            addStyle(app.ScrollPanel, s);
            app.ScrollPanel.AutoResizeChildren = 'off';
            
            % Criar Grid Layout principal dentro do painel rolável
            app.MainGrid = uigridlayout(app.ScrollPanel, [30 2]); % Aumentei para 30 linhas
            app.MainGrid.ColumnWidth = {'1x', '1x'};
            app.MainGrid.RowHeight = repmat({'fit'}, 1, 30);
            app.MainGrid.Padding = [10 10 10 10];
            app.MainGrid.RowSpacing = 10;
            
            % Título da Aplicação
            titulo = uilabel(app.MainGrid);
            titulo.Text = ['Análise de Custos - ' char(app.TipoAnalise)];
            titulo.FontSize = 16;
            titulo.FontWeight = 'bold';
            titulo.Layout.Column = [1 2];
            titulo.HorizontalAlignment = 'center';

       
            % Seção: Recursos Humanos
            hr_label = uilabel(app.MainGrid);
            hr_label.Text = 'RECURSOS HUMANOS';
            hr_label.FontWeight = 'bold';
            hr_label.BackgroundColor = [0.9 0.9 1];
            hr_label.Layout.Column = [1 2];
            
            uilabel(app.MainGrid, 'Text', 'Valor Hora/Homem (R$):');
            app.ValorHoraHomemEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Consumo Hora/Homem:');
            app.ConsumoHoraHomemEdit = uieditfield(app.MainGrid, 'numeric');
            
            % Seção: Insumos
            insumos_label = uilabel(app.MainGrid);
            insumos_label.Text = 'INSUMOS';
            insumos_label.FontWeight = 'bold';
            insumos_label.BackgroundColor = [0.9 1 0.9];
            insumos_label.Layout.Column = [1 2];
            
            uilabel(app.MainGrid, 'Text', 'Custo N₂(l) (R$/L) (Nitrogênio Líquido):');
            app.NitrogenioLiquidoEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Quantidade N₂(l) (L):');
            app.QtdNitrogenioEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Custo Grade Cu (R$/unidade) (Grades de Cobre):');
            app.GradesCuEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Quantidade Grades:');
            app.QtdGradesEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Custo Pinças (R$/unidade):');
            app.PincasEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Quantidade Pinças:');

            % Seção: Utilidades
            util_label = uilabel(app.MainGrid);
            util_label.Text = 'UTILIDADES';
            util_label.FontWeight = 'bold';
            util_label.BackgroundColor = [1 0.9 0.9];
            util_label.Layout.Column = [1 2];
            
            uilabel(app.MainGrid, 'Text', 'Custo Energia (R$/kWh):');
            app.EnergiaHoraEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Consumo Energia (kWh):');
            app.ConsumoEnergiaEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Custo H₂O (Água) (R$/m³):');
            app.AguaM3Edit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Consumo H₂O (Água) (m³):');
            app.ConsumoAguaEdit = uieditfield(app.MainGrid, 'numeric');
            
            % Seção: Custos Fixos
            fixos_label = uilabel(app.MainGrid);
            fixos_label.Text = 'CUSTOS FIXOS';
            fixos_label.FontWeight = 'bold';
            fixos_label.BackgroundColor = [1 1 0.9];
            fixos_label.Layout.Column = [1 2];
            
            uilabel(app.MainGrid, 'Text', 'Valor do Equipamento (R$):');
            app.ValorEquipamentoEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Vida Útil (meses):');
            app.VidaUtilMesesEdit = uieditfield(app.MainGrid, 'numeric');
            
            uilabel(app.MainGrid, 'Text', 'Análises Mensais:');
            app.AnalisesMensaisEdit = uieditfield(app.MainGrid, 'numeric');
            
            % Botão Calcular
            app.ExecutarButton = uibutton(app.MainGrid);
            app.ExecutarButton.Text = 'Calcular';
            app.ExecutarButton.ButtonPushedFcn = @(~,~) calcularResultados(app);
            app.ExecutarButton.Layout.Column = [1 2];

            drawnow;  % Força a atualização do layout
            
            % Tornar a interface visível
            app.UIFigure.Visible = 'on';
        end

        % Função auxiliar para tratar valores vazios
        function valor = getValueOrZero(app, campo)
            if isempty(campo.Value) || isnan(campo.Value)
                valor = 0;
            else
                valor = campo.Value;
            end
        end
        
        function calcularResultados(app)
            try
                % Cálculos dos custos por categoria
                
                % Recursos Humanos
                valorHoraHomem = app.getValueOrZero(app.ValorHoraHomemEdit);
                consumoHoraHomem = app.getValueOrZero(app.ConsumoHoraHomemEdit);
                custoHoraHomem = valorHoraHomem * consumoHoraHomem;
                
                % Insumos
                % N₂(l) (Nitrogênio Líquido)
                valorN2 = app.getValueOrZero(app.NitrogenioLiquidoEdit);
                qtdN2 = app.getValueOrZero(app.QtdNitrogenioEdit);
                custoN2 = valorN2 * qtdN2;
                
                % Cu (Grades de Cobre)
                valorGrades = app.getValueOrZero(app.GradesCuEdit);
                qtdGrades = app.getValueOrZero(app.QtdGradesEdit);
                custoGrades = valorGrades * qtdGrades;
                
                valorPincas = app.getValueOrZero(app.PincasEdit);
                qtdPincas = app.getValueOrZero(app.QtdPincasEdit);
                custoPincas = valorPincas * qtdPincas;
                
                % Utilidades
                valorEnergia = app.getValueOrZero(app.EnergiaHoraEdit);
                consumoEnergia = app.getValueOrZero(app.ConsumoEnergiaEdit);
                custoEnergia = valorEnergia * consumoEnergia;
                
                % H₂O (Água)
                valorAgua = app.getValueOrZero(app.AguaM3Edit);
                consumoAgua = app.getValueOrZero(app.ConsumoAguaEdit);
                custoAgua = valorAgua * consumoAgua;

                % Custos Fixos
                valorEquip = app.getValueOrZero(app.ValorEquipamentoEdit);
                vidaUtil = app.getValueOrZero(app.VidaUtilMesesEdit);
                analisesMensais = app.getValueOrZero(app.AnalisesMensaisEdit);
                
                % Cálculo da depreciação por análise
                if vidaUtil > 0 && analisesMensais > 0
                    custoEquipPorAnalise = valorEquip / (vidaUtil * analisesMensais);
                else
                    custoEquipPorAnalise = 0;
                end
                
                % Cálculo do custo total
                custoTotal = custoHoraHomem + custoN2 + custoGrades + ...
                            custoPincas + custoEnergia + custoAgua + ...
                            custoEquipPorAnalise;
                
                % Gerar relatório detalhado
                relatorio = sprintf('=== RELATÓRIO DE CUSTOS - ANÁLISE %s ===\n', upper(app.TipoAnalise));
                relatorio = [relatorio sprintf('Data: %s\n\n', datetime('now', 'Format', 'dd/MM/yyyy HH:mm:ss'))];
                
                % Adicionar detalhes de cada categoria com fórmulas químicas corretas
                if custoHoraHomem > 0
                    relatorio = [relatorio sprintf('1. RECURSOS HUMANOS\n')];
                    relatorio = [relatorio sprintf('   Custo Hora/Homem: R$ %.2f\n\n', custoHoraHomem)];
                end
                
                if (custoN2 + custoGrades + custoPincas) > 0
                    relatorio = [relatorio sprintf('2. INSUMOS\n')];
                    if custoN2 > 0
                        relatorio = [relatorio sprintf('   N₂(l) (Nitrogênio Líquido): R$ %.2f\n', custoN2)];
                    end
                    if custoGrades > 0
                        relatorio = [relatorio sprintf('   Cu (Grades de Cobre): R$ %.2f\n', custoGrades)];
                    end
                    if custoPincas > 0
                        relatorio = [relatorio sprintf('   Pinças de precisão: R$ %.2f\n', custoPincas)];
                    end
                    relatorio = [relatorio sprintf('\n')];
                end

                % Continuação do relatório - Utilidades
                if (custoEnergia + custoAgua) > 0
                    relatorio = [relatorio sprintf('3. UTILIDADES\n')];
                    if custoEnergia > 0
                        relatorio = [relatorio sprintf('   Energia Elétrica: R$ %.2f\n', custoEnergia)];
                    end
                    if custoAgua > 0
                        relatorio = [relatorio sprintf('   H₂O (Água): R$ %.2f\n', custoAgua)];
                    end
                    relatorio = [relatorio sprintf('\n')];
                end
                
                if custoEquipPorAnalise > 0
                    relatorio = [relatorio sprintf('4. CUSTOS FIXOS\n')];
                    relatorio = [relatorio sprintf('   Depreciação por Análise: R$ %.2f\n\n', custoEquipPorAnalise)];
                end
                
                relatorio = [relatorio sprintf('CUSTO TOTAL DA ANÁLISE: R$ %.2f\n', custoTotal)];
                
                % Exibir resultados em nova janela
                criarJanelaResultados(app, relatorio);
                
            catch ex
                msgbox(['Erro ao calcular: ' ex.message], 'Erro', 'error');
            end
        end % Fim da função calcularResultados

        function criarJanelaResultados(app, relatorio)
            % Fechar janela anterior de resultados se existir
            if isfield(app, 'ResultFigure') && isvalid(app.ResultFigure)
                delete(app.ResultFigure);
            end
            
            % Criar nova janela de resultados com rolagem
            app.ResultFigure = uifigure('Name', ['Resultados - Análise ' char(app.TipoAnalise)]);
            app.ResultFigure.Position = [app.UIFigure.Position(1) + app.UIFigure.Position(3) + 10, ...
                                       app.UIFigure.Position(2), 500, 700];
            
            % Criar painel rolável para resultados
            resultScrollPanel = uipanel(app.ResultFigure);
            resultScrollPanel.Position = [0 0 500 700];
            resultScrollPanel.Units = 'normalized';
            resultScrollPanel.Position = [0 0 1 1];
            resultScrollPanel.Scrollable = 'on';
            
            % Grid para organizar elementos dentro do painel rolável
            resultGrid = uigridlayout(resultScrollPanel, [4 2]);
            resultGrid.RowHeight = {'fit', 'fit', '1x', 'fit'};
            resultGrid.ColumnWidth = {'1x', 'fit'};
            resultGrid.Padding = [10 10 10 10];
            resultGrid.RowSpacing = 10;
            
            % Título
            tituloLabel = uilabel(resultGrid);
            tituloLabel.Text = 'RELATÓRIO DE CUSTOS';
            tituloLabel.FontSize = 16;
            tituloLabel.FontWeight = 'bold';
            tituloLabel.Layout.Column = [1 2];
            tituloLabel.HorizontalAlignment = 'center';
            
            % Subtítulo com informações do equipamento e fórmulas químicas
            subtituloLabel = uilabel(resultGrid);
            subtituloLabel.Text = ['Microscopia Eletrônica de Transmissão ' ...
                                 '(N₂(l), H₂O, Cu e outros insumos)'];
            subtituloLabel.Layout.Column = [1 2];
            subtituloLabel.HorizontalAlignment = 'center';
            
            % Área de texto para resultados com rolagem
            app.ResultadoTextArea = uitextarea(resultGrid);
            app.ResultadoTextArea.Value = strsplit(relatorio, '\n');
            app.ResultadoTextArea.Layout.Column = [1 2];
            app.ResultadoTextArea.Layout.Row = 3;
            app.ResultadoTextArea.FontName = 'Consolas';
            app.ResultadoTextArea.FontSize = 12;
            
            % Painel de botões
            buttonGrid = uigridlayout(resultGrid, [1 2]);
            buttonGrid.Layout.Column = [1 2];
            buttonGrid.Layout.Row = 4;
            buttonGrid.Padding = [5 5 5 5];
            buttonGrid.ColumnWidth = {'1x', '1x'};
            
            % Botões
            uibutton(buttonGrid, 'Text', 'Salvar CSV', ...
                'ButtonPushedFcn', @(~,~) salvarCSV(app));
            
            uibutton(buttonGrid, 'Text', 'Fechar', ...
                'ButtonPushedFcn', @(~,~) delete(app.ResultFigure));
        end
            
        function salvarCSV(app)
            try
                % Abrir diálogo para salvar arquivo
                [file, path] = uiputfile('*.csv', 'Salvar Resultados da Análise TEM');
                if file ~= 0
                    % Preparar dados para CSV com fórmulas químicas completas
                    resultados = app.ResultadoTextArea.Value;
                    
                    % Abrir arquivo para escrita com suporte a caracteres UTF-8
                    fid = fopen(fullfile(path, file), 'w', 'n', 'UTF-8');
                    
                    % Escrever BOM para UTF-8 (necessário para fórmulas químicas)
                    fprintf(fid, '\xEF\xBB\xBF');
                    
                    % Escrever cabeçalho com fórmulas químicas
                    fprintf(fid, 'Análise TEM - Custos (N₂(l) (Nitrogênio Líquido), H₂O (Água), Cu (Grades de Cobre))\n');
                    
                    % Escrever resultados
                    if ischar(resultados)
                        fprintf(fid, '%s\n', resultados);
                    else
                        for i = 1:length(resultados)
                            fprintf(fid, '%s\n', resultados{i});
                        end
                    end
                    
                    % Fechar arquivo
                    fclose(fid);
                    
                    % Mensagem de sucesso
                    msgbox('Arquivo CSV salvo com sucesso!', 'Sucesso', 'help');
                end
            catch ex
                msgbox(['Erro ao salvar arquivo: ' ex.message], 'Erro', 'error');
            end
        end
    end % Fim dos métodos private
    
    methods (Access = public)
        function app = AnaliseTemApp(tipo)
            try
                if nargin == 0
                    app.TipoAnalise = "TEM Padrão";
                else
                    app.TipoAnalise = string(tipo);
                end
                createComponents(app);
                app.UIFigure.Visible = 'on';
            catch ex
                disp(['Erro na criação da interface: ' ex.message]);
                disp(getReport(ex));
            end
        end
    end % Fim dos métodos public
end % Fim da classe AnaliseTemApp