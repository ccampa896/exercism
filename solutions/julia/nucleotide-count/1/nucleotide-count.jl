"""
    count_nucleotides(strand)

The count of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    # Inicializando o dicionário com contagem zero para cada caractere
    contador = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)

    for char in strand
        # Verifica se o caractere é uma das chaves válidas
        if haskey(contador, char)
            contador[char] += 1
        else
            throw(DomainError(char, "Caractere inválido encontrado na string."))
        end
    end

    return contador
end
