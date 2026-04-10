function transform(input::AbstractDict)
    saida = Dict{Char, Int}()
    for (ponto, letras) in input
        for letra in letras
            saida[lowercase(letra)] = ponto
        end
    end
    return saida
end