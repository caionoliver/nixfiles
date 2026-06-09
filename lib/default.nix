{ inputs, self, ... }@args:

# Importa o mkSystem.nix repassando todos os argumentos recebidos
import ./mkSystem.nix args
