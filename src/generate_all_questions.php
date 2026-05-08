<?php
$topics = [
    ["intro-ecommerce", "¿Qué significa que Shopify sea una plataforma SaaS?", "Software as a Service", "System as a Service", "Service as a System", "Software and System", 0],
    ["arquitectura-shopify", "¿Cuál es el motor de base de datos principal que usa Shopify?", "MySQL", "PostgreSQL", "MongoDB", "Oracle", 0],
    ["planes-precios", "¿Qué plan de Shopify es el nivel Enterprise?", "Shopify Plus", "Advanced Shopify", "Basic Shopify", "Starter", 0],
    ["configuracion-inicial", "¿En qué sección del admin se configuran los prefijos de pedido?", "Información de la tienda", "Pantalla de pago", "Envíos", "Mercados", 0],
    ["gestion-dominios", "¿A qué IP debe apuntar el registro A de un dominio de terceros?", "23.227.38.65", "127.0.0.1", "1.1.1.1", "8.8.8.8", 0],
    ["productos-variantes", "¿Cuál es el límite máximo de variantes por producto en Shopify estándar?", "50", "100", "200", "500", 1],
    ["colecciones-manuales", "¿Qué característica es exclusiva de las colecciones manuales?", "Ordenación personalizada drag-and-drop", "Uso de etiquetas para filtrar", "Filtros por precio", "Sincronización con Google", 0],
    ["colecciones-automatizadas", "¿Qué operador lógico se usa para requerir que se cumplan TODAS las condiciones?", "AND", "OR", "XOR", "NOT", 0],
    ["inventario-ubicaciones", "¿Cómo se llaman los lugares físicos en Shopify donde rastreas stock?", "Locations (Ubicaciones)", "Warehouses", "Stores", "Puntos de venta", 0],
    ["etiquetas-tags", "¿Cuál es el límite máximo de tags recomendado por producto?", "250", "100", "500", "1000", 0],
    ["metafields-intro", "¿Qué tres elementos componen la estructura de un Metafield?", "Namespace, Key y Value", "Title, Slug y Body", "ID, Name y Date", "Tag, Category y Price", 0],
    ["metaobjects-intro", "¿Qué ventaja ofrecen los Metaobjects sobre los Metafields?", "Pueden generar páginas dinámicas propias", "Son más baratos", "No requieren API", "Solo funcionan en Plus", 0],
    ["clientes-segmentacion", "¿Qué lenguaje se usa para crear segmentos dinámicos de clientes?", "ShopifyQL", "SQL", "Javascript", "Python", 0],
    ["b2b-shopify", "¿Qué funcionalidad es clave en el modelo B2B de Shopify?", "Catálogos de precios específicos", "Venta por Instagram", "Envío gratis siempre", "Chat en vivo", 0],
    ["canales-venta", "¿Qué app nativa de Shopify acelera el checkout en 1 clic?", "Shop App", "Facebook Channel", "Google Channel", "Messenger", 0],
    ["shopify-pos", "¿Qué dispositivo propio de Shopify permite vender en físico?", "POS Go", "Shopify Watch", "Shopify Phone", "Shopify Tablet", 0],
    ["pedidos-fulfillment", "¿Qué estado financiero indica que los fondos están retenidos pero no cobrados?", "Authorized", "Paid", "Pending", "Voided", 0],
    ["devoluciones-reembolsos", "¿Qué es una RMA?", "Autorización de devolución de mercancía", "Regla de marketing avanzado", "Registro de marca asociado", "Recibo de monto anual", 0],
    ["shopify-markets", "¿Cómo permite Markets manejar múltiples países en una tienda?", "Dominios y subcarpetas específicas", "Varias bases de datos", "Cuentas de hosting separadas", "Apps de traducción externas solamente", 0],
    ["impuestos-taxes", "¿Qué es el 'Nexus' en el contexto de impuestos de EE.UU.?", "Presencia física o económica en un estado", "Una conexión de internet", "Un modelo de datos", "Un puerto de red", 0],
    ["envios-zonas", "¿Para qué sirven los perfiles de envío?", "Agrupar productos con tarifas diferentes", "Crear perfiles de usuario", "Sincronizar con redes sociales", "Configurar el logo de la empresa", 0],
    ["pasarelas-pago", "¿Qué pasarela nativa evita comisiones adicionales por transacción?", "Shopify Payments", "PayPal", "Stripe", "Authorize.net", 0],
    ["checkout-configuracion", "¿Qué se puede configurar nativamente en el checkout estándar?", "Logo, colores y fuentes", "Código HTML libre", "Scripts de seguimiento PHP", "Nuevos pasos de pago", 0],
    ["checkout-extensibility", "¿En qué lenguaje se construyen las Checkout UI Extensions?", "React (Javascript)", "Liquid", "Ruby", "PHP", 0],
    ["descuentos-cupones", "¿Qué novedad permite Shopify con los descuentos recientemente?", "Combinar múltiples tipos de descuentos", "Descuentos de 200%", "Solo 1 descuento por vida", "Descuentos que pagan al cliente", 0],
    ["descuentos-automaticos", "¿Por qué son mejores los descuentos automáticos para la conversión?", "Eliminan la fricción de buscar códigos", "Son más caros", "Requieren más pasos", "Solo funcionan en móvil", 0],
    ["tarjetas-regalo", "¿Cómo se consideran las Gift Cards contablemente antes de ser canjeadas?", "Pasivo diferido", "Activo circulante", "Gasto de marketing", "Ingreso neto", 0],
    ["marketing-basico", "¿Cuál es el flujo de email marketing más crítico?", "Carrito abandonado", "Bienvenida", "Cumpleaños", "Newsletter semanal", 0],
    ["seo-basico", "¿Qué archivos SEO genera Shopify automáticamente?", "sitemap.xml y robots.txt", "index.html", "style.css", "script.js", 0],
    ["redirecciones-301", "¿Cuál es el código HTTP para una redirección permanente?", "301", "404", "200", "500", 0],
    ["analitica-reportes", "¿Qué mide la Tasa de Conversión (CR)?", "% de sesiones que acaban en compra", "Número de visitas", "Velocidad de la web", "Seguidores en Instagram", 0],
    ["liquid-sintaxis", "¿Quién creó originalmente el lenguaje Liquid?", "Shopify", "Wordpress", "Adobe", "Microsoft", 0],
    ["liquid-filtros", "¿Qué filtro se usa para optimizar imágenes en el CDN?", "image_url", "img_src", "resize", "crop", 0],
    ["liquid-bucles", "¿Cuál es el límite de elementos de un bucle 'for' sin paginación?", "50", "100", "500", "1000", 0],
    ["os2-arquitectura", "¿En qué formato están las plantillas en OS 2.0?", "JSON", "Liquid", "HTML", "XML", 0],
    ["os2-secciones", "¿Qué tag de Liquid define el editor visual de una sección?", "{% schema %}", "{% section %}", "{% settings %}", "{% design %}", 0],
    ["os2-app-blocks", "¿Qué ventaja tienen los App Blocks?", "No dejan basura al desinstalar la app", "Son más rápidos que Liquid", "Hacen que la app sea gratis", "Solo funcionan en PC", 0],
    ["shopify-cli", "¿Qué comando inicia el desarrollo local de temas?", "shopify theme dev", "shopify theme start", "shopify theme push", "shopify theme pull", 0],
    ["github-integration", "¿Qué ocurre al hacer 'git push' en una rama conectada?", "Shopify actualiza el tema automáticamente", "Se borra la tienda", "Nada, es manual", "Se envía un email al soporte", 0],
    ["hydrogen-oxygen", "¿Qué framework usa Hydrogen?", "Remix (React)", "Next.js", "Vue.js", "Angular", 0],
    ["storefront-api", "¿Qué tecnología usa la Storefront API?", "GraphQL", "REST", "SOAP", "Websockets", 0],
    ["admin-api-rest", "¿Por qué GraphQL es preferible a REST en Shopify?", "Evita el Over-fetching de datos", "Es más antiguo", "Solo funciona en PHP", "No requiere tokens", 0],
    ["webhooks-eventos", "¿Qué header se usa para validar la autenticidad de un webhook?", "X-Shopify-Hmac-Sha256", "X-Auth-Token", "Content-Type", "User-Agent", 0],
    ["custom-apps", "¿Dónde se instalan las Custom Apps?", "Directamente en el admin de una tienda", "En la App Store pública", "En Google Play", "No se instalan", 0],
    ["public-apps", "¿Qué API se usa para cobrar a los comerciantes en apps públicas?", "Billing API", "Payment API", "Transaction API", "Money API", 0],
    ["shopify-flow", "¿Cuál es la estructura de una automatización en Flow?", "Trigger -> Condition -> Action", "Start -> Stop -> End", "Input -> Process -> Output", "Do -> While -> Repeat", 0],
    ["shopify-functions", "¿En qué se compilan las Shopify Functions?", "WebAssembly (WASM)", "Javascript", "Python", "C#", 0],
    ["pixels-tracking", "¿Dónde se ejecutan los nuevos píxeles de tracking?", "En un Sandbox aislado (Web Worker)", "Directamente en el DOM", "En el servidor", "En la base de datos", 0],
    ["optimizacion-rendimiento", "¿Qué mide el LCP?", "El tiempo de carga del elemento visual más grande", "El número de imágenes", "El tamaño del JS", "El retraso del primer clic", 0],
    ["seguridad-fraude", "¿Qué previene el análisis de fraude nativo?", "Chargebacks (Contracargos)", "Caídas del servidor", "Virus", "Spam en comentarios", 0]
];

$sql = "\n\n-- New Questions for all 50 modules\nINSERT INTO questions (question_text, option_0, option_1, option_2, option_3, correct_answer_index, xp_reward, module_slug) VALUES\n";
$values = [];
foreach ($topics as $t) {
    $q = str_replace("'", "''", $t[1]);
    $o0 = str_replace("'", "''", $t[2]);
    $o1 = str_replace("'", "''", $t[3]);
    $o2 = str_replace("'", "''", $t[4]);
    $o3 = str_replace("'", "''", $t[5]);
    $values[] = "('$q', '$o0', '$o1', '$o2', '$o3', $t[6], 20, '$t[0]')";
}
$sql .= implode(",\n", $values) . ";\n";

file_put_contents("database.sql", $sql, FILE_APPEND);
echo "Added 50 new questions to database.sql\n";
