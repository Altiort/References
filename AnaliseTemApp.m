classdef AnaliseTemApp < matlab.apps.AppBase
    properties (Access = private)
        % Interface principal
        UIFigure            matlab.ui.Figure
        MainGrid            matlab.ui.container.GridLayout
        TabGroup            matlab.ui.container.TabGroup
        MainMenu            matlab.ui.container.Menu
        CalcularButton      matlab.ui.container.Menu
        
        % Janela de resultados
        ResultFigure        matlab.ui.Figure
        ResultadoTextArea   matlab.ui.control.TextArea
        
        % Abas
        RecursosHumanosTab  matlab.ui.container.Tab
        InsumosTab          matlab.ui.container.Tab
        UtilidadesTab       matlab.ui.container.Tab
        CustosFixosTab      matlab.ui.container.Tab
        GasesTab            matlab.ui.container.Tab
        
        % Campos - Recursos Humanos
        ValorHoraHomemEdit     matlab.ui.control.NumericEditField
        ConsumoHoraHomemEdit   matlab.ui.control.NumericEditField
        TipoBolsaEdit          matlab.ui.control.EditField
        ValorBolsaEdit         matlab.ui.control.NumericEditField
        ConsumoHoraBolsaEdit   matlab.ui.control.NumericEditField
        
        % Campos - Insumos (Cu (Grades de Cobre), Resina Epóxi, Lâminas de Vidro, Recipientes)
        GradesCuPacoteEdit            matlab.ui.control.NumericEditField
        GradesAnaliseEdit             matlab.ui.control.NumericEditField
        ResinaEpoxiEdit               matlab.ui.control.NumericEditField
        LaminasVidroEdit              matlab.ui.control.NumericEditField
        RecipientesLiquidoEdit        matlab.ui.control.NumericEditField
        RecipientesMicropulverulentoEdit matlab.ui.control.NumericEditField
        GradesOuroPacoteEdit          matlab.ui.control.NumericEditField
        
        % Campos - Utilidades
        EnergiaKwhEdit                matlab.ui.control.NumericEditField
        ConsumoEnergiaHoraEdit        matlab.ui.control.NumericEditField
        TempoUsoEnergiaEdit           matlab.ui.control.NumericEditField
        AguaM3Edit                    matlab.ui.control.NumericEditField
        ConsumoAguaHoraEdit           matlab.ui.control.NumericEditField
        TempoUsoAguaEdit              matlab.ui.control.NumericEditField
        
        % Campos - Gases
        NitrogenioReservatorioEdit    matlab.ui.control.NumericEditField
        ConsumoNitrogenioHoraEdit     matlab.ui.control.NumericEditField
        TempoAnaliseNitrogenioEdit    matlab.ui.control.NumericEditField
        ArgonioReservatorioEdit       matlab.ui.control.NumericEditField
        ConsumoArgonioHoraEdit        matlab.ui.control.NumericEditField
        TempoAnaliseArgonioEdit       matlab.ui.control.NumericEditField
        OxigenioReservatorioEdit      matlab.ui.control.NumericEditField
        ConsumoOxigenioHoraEdit       matlab.ui.control.NumericEditField
        TempoAnaliseOxigenioEdit      matlab.ui.control.NumericEditField
        HelioReservatorioEdit         matlab.ui.control.NumericEditField
        ConsumoHelioHoraEdit          matlab.ui.control.NumericEditField
        TempoAnaliseHelioEdit         matlab.ui.control.NumericEditField
        
        % Campos - Custos Fixos
        ValorMicroscopioEdit          matlab.ui.control.NumericEditField
        VidaUtilMicroscopioEdit       matlab.ui.control.NumericEditField
        ValorUMTEdit                  matlab.ui.control.NumericEditField
        VidaUtilUMTEdit               matlab.ui.control.NumericEditField
        ValorEdificacaoEdit           matlab.ui.control.NumericEditField
        VidaUtilEdificacaoEdit        matlab.ui.control.NumericEditField
        AnalisesMensaisEdit           matlab.ui.control.NumericEditField
        
        % Campos - EPIs
        LuvasNitrilaEdit              matlab.ui.control.NumericEditField
        OculosProtecaoEdit            matlab.ui.control.NumericEditField
        AventaisLaboratorioEdit       matlab.ui.control.NumericEditField
        
        % Propriedades do sistema
        TipoAnalise          string
    end
    
    methods (Access = private)
        function createComponents(app)
            % Criar janela principal
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1000 700];
            app.UIFigure.Name = ['Análise ' char(app.TipoAnalise) ' - Cálculo de Custos'];
            
            % Menu principal
            app.MainMenu = uimenu(app.UIFigure, 'Text', 'Operações');
            app.CalcularButton = uimenu(app.MainMenu, 'Text', 'Calcular', 'MenuSelectedFcn', @(~,~) calcularResultados(app));
            
            % Grid principal
            app.MainGrid = uigridlayout(app.UIFigure, [1 1]);
            app.MainGrid.Padding = [10 10 10 10];
            
            % Grupo de abas
            app.TabGroup = uitabgroup(app.MainGrid);
            
            % Aba - Recursos Humanos
            app.RecursosHumanosTab = uitab(app.TabGroup, 'Title', 'Recursos Humanos');
            rhGrid = uigridlayout(app.RecursosHumanosTab, [3 2]);
            
            % Técnicos
            uilabel(rhGrid, 'Text', 'Valor Hora/Homem (R$):');
            app.ValorHoraHomemEdit = uieditfield(rhGrid, 'numeric');
            
            uilabel(rhGrid, 'Text', 'Tempo de operação (horas):');
            app.ConsumoHoraHomemEdit = uieditfield(rhGrid, 'numeric');
            
            % Bolsistas
            uilabel(rhGrid, 'Text', 'Tipo de Bolsa:');
            app.TipoBolsaEdit = uieditfield(rhGrid, 'text');
            
            uilabel(rhGrid, 'Text', 'Valor da Bolsa (R$):');
            app.ValorBolsaEdit = uieditfield(rhGrid, 'numeric');
            
            uilabel(rhGrid, 'Text', 'Consumo de Hora/Homem na Análise:');
            app.ConsumoHoraBolsaEdit = uieditfield(rhGrid, 'numeric');
            
            % Aba - Insumos
            app.InsumosTab = uitab(app.TabGroup, 'Title', 'Insumos');
            insumosGrid = uigridlayout(app.InsumosTab, [7 2]);
            
            % Cu (Grades de Cobre)
            uilabel(insumosGrid, 'Text', 'Custo pacote grades Cu (R$/100un):');
            app.GradesCuPacoteEdit = uieditfield(insumosGrid, 'numeric');
            
            uilabel(insumosGrid, 'Text', 'Quantidade de grades por análise:');
            app.GradesAnaliseEdit = uieditfield(insumosGrid, 'numeric');
            
            % Resina Epóxi
            uilabel(insumosGrid, 'Text', 'Custo Resina Epóxi (R$/g):');
            app.ResinaEpoxiEdit = uieditfield(insumosGrid, 'numeric');
            
            % Lâminas de Vidro para Ultramicrotomo
            uilabel(insumosGrid, 'Text', 'Custo Lâminas de Vidro (R$/un):');
            app.LaminasVidroEdit = uieditfield(insumosGrid, 'numeric');
            
            % Recipientes para Material Líquido
            uilabel(insumosGrid, 'Text', 'Custo Recipientes para Material Líquido (R$/un):');
            app.RecipientesLiquidoEdit = uieditfield(insumosGrid, 'numeric');
            
            % Recipientes para Material Micropulverulento
            uilabel(insumosGrid, 'Text', 'Custo Recipientes para Material Micropulverulento (R$/un):');
            app.RecipientesMicropulverulentoEdit = uieditfield(insumosGrid, 'numeric');
            
            % Grades de Ouro
            uilabel(insumosGrid, 'Text', 'Custo pacote grades Au (R$/100un):');
            app.GradesOuroPacoteEdit = uieditfield(insumosGrid, 'numeric');
            
            % Aba - Utilidades
            app.UtilidadesTab = uitab(app.TabGroup, 'Title', 'Utilidades');
            utilGrid = uigridlayout(app.UtilidadesTab, [3 2]);
            
            % Energia Elétrica
            uilabel(utilGrid, 'Text', 'Custo Energia (R$/kWh):');
            app.EnergiaKwhEdit = uieditfield(utilGrid, 'numeric');
            
            uilabel(utilGrid, 'Text', 'Consumo por hora (kWh):');
            app.ConsumoEnergiaHoraEdit = uieditfield(utilGrid, 'numeric');
            
            uilabel(utilGrid, 'Text', 'Tempo de uso (horas):');
            app.TempoUsoEnergiaEdit = uieditfield(utilGrid, 'numeric');
            
            % H₂O (Água)
            uilabel(utilGrid, 'Text', 'Custo H₂O por m³ (R$):');
            app.AguaM3Edit = uieditfield(utilGrid, 'numeric');
            
            uilabel(utilGrid, 'Text', 'Consumo H₂O por hora (m³/h):');
            app.ConsumoAguaHoraEdit = uieditfield(utilGrid, 'numeric');
            
            uilabel(utilGrid, 'Text', 'Tempo de uso H₂O (horas):');
            app.TempoUsoAguaEdit = uieditfield(utilGrid, 'numeric');
            
            % Aba - Gases
            app.GasesTab = uitab(app.TabGroup, 'Title', 'Gases');
            gasesGrid = uigridlayout(app.GasesTab, [8 2]);
            
            % N₂(l) (Nitrogênio Líquido)
            uilabel(gasesGrid, 'Text', 'Custo do reservatório N₂(l) 50L (R$):');
            app.NitrogenioReservatorioEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Consumo N₂(l) por hora (L/h):');
            app.ConsumoNitrogenioHoraEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Tempo de análise (horas):');
            app.TempoAnaliseNitrogenioEdit = uieditfield(gasesGrid, 'numeric');
            
            % Ar (Argônio)
            uilabel(gasesGrid, 'Text', 'Custo do reservatório Ar (Argônio) (R$):');
            app.ArgonioReservatorioEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Consumo Ar por hora (L/h):');
            app.ConsumoArgonioHoraEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Tempo de análise (horas):');
            app.TempoAnaliseArgonioEdit = uieditfield(gasesGrid, 'numeric');
            
            % O₂ (Oxigênio)
            uilabel(gasesGrid, 'Text', 'Custo do reservatório O₂ (Oxigênio) (R$):');
            app.OxigenioReservatorioEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Consumo O₂ por hora (L/h):');
            app.ConsumoOxigenioHoraEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Tempo de análise (horas):');
            app.TempoAnaliseOxigenioEdit = uieditfield(gasesGrid, 'numeric');
            
            % He (Hélio)
            uilabel(gasesGrid, 'Text', 'Custo do reservatório He (Hélio) (R$):');
            app.HelioReservatorioEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Consumo He por hora (L/h):');
            app.ConsumoHelioHoraEdit = uieditfield(gasesGrid, 'numeric');
            
            uilabel(gasesGrid, 'Text', 'Tempo de análise (horas):');
            app.TempoAnaliseHelioEdit = uieditfield(gasesGrid, 'numeric');
            
            % Aba - Custos Fixos
            app.CustosFixosTab = uitab(app.TabGroup, 'Title', 'Custos Fixos');
            fixosGrid = uigridlayout(app.CustosFixosTab, [8 2]);
            
            % Microscópio
            uilabel(fixosGrid, 'Text', 'Valor do Microscópio (R$):');
            app.ValorMicroscopioEdit = uieditfield(fixosGrid, 'numeric');
            
            uilabel(fixosGrid, 'Text', 'Vida Útil Microscópio (meses):');
            app.VidaUtilMicroscopioEdit = uieditfield(fixosGrid, 'numeric');
            
            % UMT (Ultramicrotomo)
            uilabel(fixosGrid, 'Text', 'Valor do UMT (R$):');
            app.ValorUMTEdit = uieditfield(fixosGrid, 'numeric');
            
            uilabel(fixosGrid, 'Text', 'Vida Útil UMT (meses):');
            app.VidaUtilUMTEdit = uieditfield(fixosGrid, 'numeric');
            
            % Edificação
            uilabel(fixosGrid, 'Text', 'Valor da Edificação (R$):');
            app.ValorEdificacaoEdit = uieditfield(fixosGrid, 'numeric');
            
            uilabel(fixosGrid, 'Text', 'Vida Útil Edificação (meses):');
            app.VidaUtilEdificacaoEdit = uieditfield(fixosGrid, 'numeric');
            
            % Análises mensais
            uilabel(fixosGrid, 'Text', 'Análises Mensais:');
            app.AnalisesMensaisEdit = uieditfield(fixosGrid, 'numeric');
            
            % EPIs
            uilabel(fixosGrid, 'Text', 'Custo Luvas de Nitrila (R$/par):');
            app.LuvasNitrilaEdit = uieditfield(fixosGrid, 'numeric');
            
            uilabel(fixosGrid, 'Text', 'Custo Óculos de Proteção (R$/un):');
            app.OculosProtecaoEdit = uieditfield(fixosGrid, 'numeric');
            
            uilabel(fixosGrid, 'Text', 'Custo Aventais de Laboratório (R$/un):');
            app.AventaisLaboratorioEdit = uieditfield(fixosGrid, 'numeric');
            
            % Tornar visível
            app.UIFigure.Visible = 'on';
        end
        
        function calcularResultados(app)
            % Função auxiliar para tratar valores vazios
            function valor = getValueOrZero(campo)
                if isempty(campo.Value) || isnan(campo.Value)
                    valor = 0;
                else
                    valor = campo.Value;
                end
            end

            try    
                % Cálculo Recursos Humanos
                custoHoraHomem = getValueOrZero(app.ValorHoraHomemEdit) * getValueOrZero(app.ConsumoHoraHomemEdit);
                custoHoraBolsa = getValueOrZero(app.ValorBolsaEdit) * getValueOrZero(app.ConsumoHoraBolsaEdit);
                
                % Cálculo Insumos
                % Cu (Cobre)
                custoGradeUnidade = getValueOrZero(app.GradesCuPacoteEdit) / 100;
                custoGradesTotal = custoGradeUnidade * getValueOrZero(app.GradesAnaliseEdit);
                
                % Resina Epóxi
                custoResinaEpoxi = getValueOrZero(app.ResinaEpoxiEdit);
                
                % Lâminas de Vidro para Ultramicrotomo
                custoLaminasVidro = getValueOrZero(app.LaminasVidroEdit);
                
                % Recipientes para Material Líquido
                custoRecipientesLiquido = getValueOrZero(app.RecipientesLiquidoEdit);
                
                % Recipientes para Material Micropulverulento
                custoRecipientesMicropulverulento = getValueOrZero(app.RecipientesMicropulverulentoEdit);
                
                % Grades de Ouro
                custoGradesOuro = getValueOrZero(app.GradesOuroPacoteEdit) / 100;
                
                % H₂O (Água)
                custoAguaHora = getValueOrZero(app.AguaM3Edit) * getValueOrZero(app.ConsumoAguaHoraEdit);
                custoAguaTotal = custoAguaHora * getValueOrZero(app.TempoUsoAguaEdit);
                
                % Cálculo Utilidades
                custoEnergiaHora = getValueOrZero(app.EnergiaKwhEdit) * getValueOrZero(app.ConsumoEnergiaHoraEdit);
                custoEnergiaTotal = custoEnergiaHora * getValueOrZero(app.TempoUsoEnergiaEdit);
                
                % Cálculo Gases
                custoNitrogenioHora = (getValueOrZero(app.NitrogenioReservatorioEdit) / 50) * getValueOrZero(app.ConsumoNitrogenioHoraEdit);
                custoNitrogenioTotal = custoNitrogenioHora * getValueOrZero(app.TempoAnaliseNitrogenioEdit);
                
                custoArgonioHora = (getValueOrZero(app.ArgonioReservatorioEdit) / 50) * getValueOrZero(app.ConsumoArgonioHoraEdit);
                custoArgonioTotal = custoArgonioHora * getValueOrZero(app.TempoAnaliseArgonioEdit);
                
                custoOxigenioHora = (getValueOrZero(app.OxigenioReservatorioEdit) / 50) * getValueOrZero(app.ConsumoOxigenioHoraEdit);
                custoOxigenioTotal = custoOxigenioHora * getValueOrZero(app.TempoAnaliseOxigenioEdit);
                
                custoHelioHora = (getValueOrZero(app.HelioReservatorioEdit) / 50) * getValueOrZero(app.ConsumoHelioHoraEdit);
                custoHelioTotal = custoHelioHora * getValueOrZero(app.TempoAnaliseHelioEdit);
                
                                % Cálculo Custos Fixos por Análise
                analisesMensais = getValueOrZero(app.AnalisesMensaisEdit);
                if analisesMensais > 0
                    custoMicroscopio = getValueOrZero(app.ValorMicroscopioEdit) / (getValueOrZero(app.VidaUtilMicroscopioEdit) * analisesMensais);
                    custoUMT = getValueOrZero(app.ValorUMTEdit) / (getValueOrZero(app.VidaUtilUMTEdit) * analisesMensais);
                    custoEdificacao = getValueOrZero(app.ValorEdificacaoEdit) / (getValueOrZero(app.VidaUtilEdificacaoEdit) * analisesMensais);
                else
                    custoMicroscopio = 0;
                    custoUMT = 0;
                    custoEdificacao = 0;
                end
                
                % EPIs
                custoLuvasNitrila = getValueOrZero(app.LuvasNitrilaEdit);
                custoOculosProtecao = getValueOrZero(app.OculosProtecaoEdit);
                custoAventaisLaboratorio = getValueOrZero(app.AventaisLaboratorioEdit);
                
                % Custo Total
                custoTotal = custoHoraHomem + custoHoraBolsa + custoGradesTotal + custoResinaEpoxi + ...
                    custoLaminasVidro + custoRecipientesLiquido + custoRecipientesMicropulverulento + custoGradesOuro + ...
                    custoAguaTotal + custoEnergiaTotal + custoNitrogenioTotal + custoArgonioTotal + custoOxigenioTotal + custoHelioTotal + ...
                    custoMicroscopio + custoUMT + custoEdificacao + custoLuvasNitrila + custoOculosProtecao + custoAventaisLaboratorio;
                
                % Criar relatório detalhado
                criarJanelaResultados(app, custoHoraHomem, custoHoraBolsa, custoGradesTotal, custoResinaEpoxi, ...
                    custoLaminasVidro, custoRecipientesLiquido, custoRecipientesMicropulverulento, custoGradesOuro, ...
                    custoAguaTotal, custoEnergiaTotal, custoNitrogenioTotal, custoArgonioTotal, custoOxigenioTotal, custoHelioTotal, ...
                    custoMicroscopio, custoUMT, custoEdificacao, custoLuvasNitrila, custoOculosProtecao, custoAventaisLaboratorio, custoTotal);
            catch ex
                msgbox(['Erro ao calcular: ' ex.message], 'Erro', 'error');
            end
        end
        
        function criarJanelaResultados(app, custoHoraHomem, custoHoraBolsa, custoGrades, custoResinaEpoxi, ...
                custoLaminasVidro, custoRecipientesLiquido, custoRecipientesMicropulverulento, custoGradesOuro, ...
                custoAgua, custoEnergia, custoNitrogenio, custoArgonio, custoOxigenio, custoHelio, ...
                custoMicroscopio, custoUMT, custoEdificacao, custoLuvasNitrila, custoOculosProtecao, custoAventaisLaboratorio, custoTotal)
            
            % Fechar janela anterior se existir
            if isfield(app, 'ResultFigure') && isvalid(app.ResultFigure)
                delete(app.ResultFigure);
            end
            
            % Nova janela de resultados
            app.ResultFigure = uifigure('Name', ['Resultados - Análise ' char(app.TipoAnalise)]);
            app.ResultFigure.Position = [app.UIFigure.Position(1) + app.UIFigure.Position(3) + 10, app.UIFigure.Position(2), 500, 600];
            
            % Grid para resultados
            resultGrid = uigridlayout(app.ResultFigure, [3 1]);
            resultGrid.RowHeight = {'1x', 'fit', 'fit'};
            
            % Área de texto para resultados
            app.ResultadoTextArea = uitextarea(resultGrid);
            app.ResultadoTextArea.Value = {
                '=== RELATÓRIO DE CUSTOS ===';
                ['Data: ' char(datetime('now', 'Format', 'dd/MM/yyyy HH:mm:ss'))];
                '';
                '1. RECURSOS HUMANOS';
                sprintf('   Custo Técnico: R$ %.2f', custoHoraHomem);
                sprintf('   Custo Bolsista: R$ %.2f', custoHoraBolsa);
                '';
                '2. INSUMOS';
                sprintf('   Cu (Grades de Cobre): R$ %.2f', custoGrades);
                sprintf('   Resina Epóxi: R$ %.2f', custoResinaEpoxi);
                sprintf('   Lâminas de Vidro: R$ %.2f', custoLaminasVidro);
                sprintf('   Recipientes para Material Líquido: R$ %.2f', custoRecipientesLiquido);
                sprintf('   Recipientes para Material Micropulverulento: R$ %.2f', custoRecipientesMicropulverulento);
                sprintf('   Au (Grades de Ouro): R$ %.2f', custoGradesOuro);
                sprintf('   Subtotal Insumos: R$ %.2f', custoGrades + custoResinaEpoxi + custoLaminasVidro + custoRecipientesLiquido + custoRecipientesMicropulverulento + custoGradesOuro);
                '';
                '3. UTILIDADES';
                sprintf('   Energia Elétrica: R$ %.2f', custoEnergia);
                sprintf('   H₂O (Água): R$ %.2f', custoAgua);
                sprintf('   Subtotal Utilidades: R$ %.2f', custoEnergia + custoAgua);
                '';
                '4. GASES';
                sprintf('   N₂(l) (Nitrogênio Líquido): R$ %.2f', custoNitrogenio);
                sprintf('   Ar (Argônio): R$ %.2f', custoArgonio);
                sprintf('   O₂ (Oxigênio): R$ %.2f', custoOxigenio);
                sprintf('   He (Hélio): R$ %.2f', custoHelio);
                sprintf('   Subtotal Gases: R$ %.2f', custoNitrogenio + custoArgonio + custoOxigenio + custoHelio);
                '';
                '5. CUSTOS FIXOS (por análise)';
                sprintf('   Microscópio: R$ %.2f', custoMicroscopio);
                sprintf('   UMT (Ultramicrotomo): R$ %.2f', custoUMT);
                sprintf('   Edificação: R$ %.2f', custoEdificacao);
                sprintf('   Subtotal Custos Fixos: R$ %.2f', custoMicroscopio + custoUMT + custoEdificacao);
                '';
                '6. EPIs';
                sprintf('   Luvas de Nitrila: R$ %.2f', custoLuvasNitrila);
                sprintf('   Óculos de Proteção: R$ %.2f', custoOculosProtecao);
                sprintf('   Aventais de Laboratório: R$ %.2f', custoAventaisLaboratorio);
                sprintf('   Subtotal EPIs: R$ %.2f', custoLuvasNitrila + custoOculosProtecao + custoAventaisLaboratorio);
                '';
                '=== CUSTO TOTAL DA ANÁLISE ===';
                sprintf('R$ %.2f', custoTotal)
            };
            
            % Botões
            buttonGrid = uigridlayout(resultGrid, [1 2]);
            buttonGrid.Padding = [10 10 10 10];
            buttonGrid.ColumnWidth = {'1x', '1x'};
            
            uibutton(buttonGrid, 'Text', 'Salvar CSV', 'ButtonPushedFcn', @(~,~) salvarCSV(app));
            
            uibutton(buttonGrid, 'Text', 'Fechar', 'ButtonPushedFcn', @(~,~) delete(app.ResultFigure));
        end
        
        function salvarCSV(app)
            try
                [file, path] = uiputfile('*.csv', 'Salvar Resultados');
                if file ~= 0
                    fid = fopen(fullfile(path, file), 'w', 'n', 'UTF-8');
                    fprintf(fid, '\xEF\xBB\xBF'); % BOM para UTF-8
                    
                    % Escrever conteúdo
                    resultados = app.ResultadoTextArea.Value;
                    for i = 1:length(resultados)
                        fprintf(fid, '%s\n', resultados{i});
                    end
                    
                    fclose(fid);
                    msgbox('Arquivo CSV salvo com sucesso!', 'Sucesso', 'help');
                end
            catch ex
                msgbox(['Erro ao salvar arquivo: ' ex.message], 'Erro', 'error');
            end
        end
    end
    
    methods (Access = public)
        function app = AnaliseTemApp(tipo)
            try
                if nargin == 0
                    app.TipoAnalise = "TEM Padrão";
                else
                    app.TipoAnalise = string(tipo);
                end
                createComponents(app);
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