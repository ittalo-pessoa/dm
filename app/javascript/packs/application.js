// Este arquivo é automaticamente compilado pelo Webpack, junto com quaisquer outros arquivos
// presentes neste diretório. Recomenda-se colocar sua lógica de aplicação real
// em uma estrutura relevante dentro de app/javascript e usar apenas esses arquivos
// de pacote para fazer referência a esse código para que ele seja compilado.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// Importações para Bootstrap e estilos
import "bootstrap";
import "@popperjs/core"; // Dependência do Bootstrap
import "stylesheets/application"; // Certifique-se de que este caminho está correto

//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require turbolinks
//= require_tree .


// Inicialização de bibliotecas
Rails.start();
Turbolinks.start();
ActiveStorage.start();
