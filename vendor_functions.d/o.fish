command --query ollama &>/dev/null; or return (ret "ollama not on PATH?")

function o -w ollama
    ollama $args
end