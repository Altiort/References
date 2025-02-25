classdef TipoAnalise
    enumeration
        PCM_SUPERFICIE('Análise de Superfície PCM')
        PCM_TINTA('PCM em Tinta Acrílica')
        PCM_ARGAMASSA('PCM em Argamassa')
        PCM_COMPOSICAO('Composição de PCM')
        BIOPOLIMEROS('Síntese de Biopolímeros')
        BIOCELULOSE('Análise de Biocelulose')
        FIBRAS_NATURAIS('Fibras Naturais')
        IMPREGNACAO('Impregnação de Fibras')
    end
    
    properties
        Nome char
    end
    
    methods
        function obj = TipoAnalise(nome)
            obj.Nome = nome;
        end
    end
end