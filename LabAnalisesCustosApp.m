classdef LabAnalisesCustosApp < matlab.apps.AppBase
    % [... outras propriedades permanecem iguais ...]
    
    methods (Access = private)
        function criarAbaConsumiveis(app)
            % Criação da aba Consumíveis
            app.ConsumiveisTab = uitab(app.TabGroup);
            app.ConsumiveisTab.Title = 'Consumíveis';
            
            % Grid para organização dos elementos
            grid = uigridlayout(app.ConsumiveisTab, [8 2]);
            grid.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            grid.ColumnWidth = {'2x', '1x'};
            
            % Labels e campos para N₂(l) (Nitrogênio Líquido)
            uilabel(grid, 'Text', 'N₂(l) (Nitrogênio Líquido) - L/análise');
            app.NitrogenioEdit = uieditfield(grid, 'numeric');
            
            % Labels e campos para H₂O(l) (Água Líquida)
            uilabel(grid, 'Text', 'H₂O(l) (Água Líquida) - L/análise');
            app.AguaEdit = uieditfield(grid, 'numeric');
            
            % Labels e campos para Fe-Cr-Ni (Liga de Aço Inoxidável)
            uilabel(grid, 'Text', 'Fe-Cr-Ni (Liga de Aço Inoxidável) - unidades');
            app.InoxEdit = uieditfield(grid, 'numeric');
            
            % Labels e campos para Cu (Cobre)
            uilabel(grid, 'Text', 'Cu (Cobre) - grades/análise');
            app.CobreEdit = uieditfield(grid, 'numeric');
            
            % Labels e campos para Au (Ouro)
            uilabel(grid, 'Text', 'Au (Ouro) - grades/análise');
            app.OuroEdit = uieditfield(grid, 'numeric');
            
            % Labels e campos para C (Carbono)
            uilabel(grid, 'Text', 'C (Carbono) - filmes/análise');
            app.CarbonoEdit = uieditfield(grid, 'numeric');
            
            % Labels e campos para SiO₂ (Dióxido de Silício)
            uilabel(grid, 'Text', 'SiO₂ (Dióxido de Silício) - g/análise');
            app.SilicaEdit = uieditfield(grid, 'numeric');
            
            % Labels e campos para Al₂O₃ (Óxido de Alumínio)
            uilabel(grid, 'Text', 'Al₂O₃ (Óxido de Alumínio) - g/análise');
            app.AluminaEdit = uieditfield(grid, 'numeric');
        end

        function criarAbaRecursosHumanos(app)
            % Criação da aba Recursos Humanos
            app.RecursosHumanosTab = uitab(app.TabGroup);
            app.RecursosHumanosTab.Title = 'Recursos Humanos';
            
            % Grid para organização dos elementos
            grid = uigridlayout(app.RecursosHumanosTab, [6 3]);
            grid.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x'};
            grid.ColumnWidth = {'2x', '1x', '1x'};
            
            % Campos para técnico
            uilabel(grid, 'Text', 'Valor Hora Técnico (R$)');
            app.ValorHoraHomemEdit = uieditfield(grid, 'numeric');
            app.ConsumoHoraHomemEdit = uieditfield(grid, 'numeric');
            
            % Campos para bolsista
            uilabel(grid, 'Text', 'Tipo de Bolsa');
            app.TipoBolsaEdit = uieditfield(grid, 'text');
            app.ValorBolsaEdit = uieditfield(grid, 'numeric');
        end
        
        % [... outras funções de criação de abas seguem o mesmo padrão ...]
    end
end