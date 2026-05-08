import json

questions = [
    # Liquid Basics
    ("¿Qué lenguaje de plantillas utiliza Shopify para sus temas?", "PHP", "Liquid", "Jinja", "Blade", 1, 10),
    ("¿Qué símbolo se usa en Liquid para mostrar la salida de una variable (Output)?", "{% %}", "[[ ]]", "{{ }}", "<?php ?>", 2, 10),
    ("¿Qué hace el carácter de tubería '|' en Liquid?", "Cierra un bloque if", "Aplica un filtro a una variable", "Concatena strings", "Comenta código", 1, 10),
    ("¿Cómo se comenta código en Liquid?", "{# comentario #}", "<!-- comentario -->", "{% comment %} comentario {% endcomment %}", "// comentario", 2, 10),
    ("¿Cuál es el objeto global en Liquid que contiene la información de la tienda?", "store", "shop", "global", "settings", 1, 10),
    ("¿Qué etiqueta se usa para iterar sobre una colección de productos en Liquid?", "{% loop %}", "{% foreach %}", "{% for %}", "{% iterate %}", 2, 10),
    ("¿Cómo se asigna un valor a una variable en Liquid?", "{% set var = 'valor' %}", "{% assign var = 'valor' %}", "{{ var = 'valor' }}", "{% let var = 'valor' %}", 1, 10),
    ("¿Qué filtro se usa para convertir un texto a mayúsculas en Liquid?", "upcase", "upper", "capitalize", "uppercase", 0, 10),
    ("¿Cómo capturas un bloque de texto en una variable en Liquid?", "{% capture var %}...{% endcapture %}", "{% assign block var %}...{% endassign %}", "{% block var %}...{% endblock %}", "{% save var %}...{% endsave %}", 0, 15),
    ("¿Qué hace el tag {% include %} en Liquid (obsoleto)?", "Importa una librería de JS", "Inserta un snippet", "Incluye una app de terceros", "Carga un producto", 1, 15),
    ("¿Qué tag se recomienda usar en lugar de {% include %} en versiones modernas de Shopify?", "{% insert %}", "{% require %}", "{% render %}", "{% snippet %}", 2, 15),
    ("¿Cuál de estos es un tipo de dato válido en Liquid?", "Array", "String", "Number", "Todos los anteriores", 3, 10),
    ("¿Cómo verificas si una variable está vacía en Liquid?", "{% if var == empty %}", "{% if var == blank %}", "{% if var == null %}", "{% if var == '' %}", 1, 15),
    ("¿Qué filtro se usa para dar formato de dinero a un número en Liquid?", "money", "currency", "format_money", "price", 0, 10),
    ("¿Qué objeto Liquid se usa para acceder a los ajustes del tema?", "theme.settings", "settings", "shop.theme", "configuration", 1, 15),

    # Products & Inventory
    ("¿Qué es un SKU en la gestión de inventario?", "Una pasarela de pago", "Un código de barras universal", "Una unidad de seguimiento de stock", "Un impuesto", 2, 10),
    ("¿Cuántas opciones (ej. Talla, Color) permite Shopify por defecto por producto?", "1", "2", "3", "Ilimitadas", 2, 15),
    ("¿Cuántas variantes en total puede tener un producto en Shopify?", "50", "100", "200", "500", 1, 15),
    ("Si un producto tiene 3 colores y 4 tallas, ¿cuántas variantes se crean?", "7", "12", "3", "4", 1, 10),
    ("¿Qué objeto en Liquid representa una variante individual de un producto?", "product.variant", "variant", "product.options", "item.variant", 1, 15),
    ("¿Qué indica la propiedad variant.inventory_quantity?", "El precio de la variante", "El peso de la variante", "La cantidad en stock de la variante", "El número de SKU", 2, 10),
    ("¿Qué significa 'Continuar vendiendo cuando esté agotado' en Shopify?", "Que el producto se oculta", "Que los clientes pueden hacer pre-pedidos sin stock", "Que el precio cambia a 0", "Que se desactiva el SKU", 1, 10),
    ("¿Qué es un 'Vendor' en un producto de Shopify?", "El precio de coste", "La marca o proveedor del producto", "El tipo de producto", "El peso para el envío", 1, 10),
    ("¿Para qué se utilizan los 'Tags' (Etiquetas) en los productos?", "Para organizar y filtrar productos", "Para definir el precio", "Para asignar el stock", "Para crear el SKU", 0, 10),
    ("¿Qué formato de imagen recomienda Shopify para productos?", "BMP", "TIFF", "WebP o JPEG", "SVG", 2, 10),
    ("¿Qué es una colección 'Automatizada' en Shopify?", "Una colección que los clientes crean", "Una colección que añade productos basados en condiciones", "Una colección que cambia de precio", "Una colección vacía", 1, 10),
    ("¿Qué objeto de Liquid representa una colección?", "category", "collection", "group", "product_list", 1, 10),
    ("¿Cómo accedes a todos los productos de una colección en Liquid?", "collection.items", "collection.all", "collection.products", "collection.list", 2, 10),

    # Checkout & Orders
    ("En el plan estándar de Shopify, ¿qué parte del checkout puedes modificar usando código HTML/CSS libremente?", "Todo el checkout", "Solo la cabecera", "Ninguna parte, solo estilos visuales desde el editor", "El botón de pago", 2, 15),
    ("¿Qué plan de Shopify permite modificar el checkout.liquid?", "Shopify Basic", "Shopify Plan", "Advanced Shopify", "Shopify Plus", 3, 20),
    ("¿Dónde configuras si el número de teléfono es obligatorio en el checkout?", "En la configuración de Envíos", "En la configuración de Pantalla de pago", "En el editor de temas", "En la configuración de Impuestos", 1, 10),
    ("¿Qué es un carrito abandonado?", "Un pedido reembolsado", "Un usuario que añade productos pero no completa el pago", "Un producto sin stock", "Una devolución", 1, 10),
    ("¿Puede Shopify enviar correos automáticos de carritos abandonados?", "Sí, está integrado de forma nativa", "No, necesitas una app de terceros", "Solo en Shopify Plus", "Solo si el cliente ya ha comprado antes", 0, 15),
    ("¿Qué estado tiene un pedido cuando el pago fue exitoso pero no se ha enviado?", "Completado", "Pendiente de pago", "No preparado (Unfulfilled)", "Archivado", 2, 15),
    ("¿Qué es el 'Fulfillment' en Shopify?", "El proceso de preparar y enviar el pedido", "El reembolso del pedido", "El pago del pedido", "La creación de un producto", 0, 10),
    ("¿Qué objeto de Liquid se usa en la página del carrito?", "cart", "basket", "order", "checkout", 0, 10),
    ("¿Cómo iteras sobre los artículos del carrito en Liquid?", "{% for item in cart.items %}", "{% for product in cart.products %}", "{% for line in cart.lines %}", "{% for item in checkout.items %}", 0, 15),
    ("¿Qué hace cart.total_price?", "Devuelve el peso total", "Devuelve el precio total en formato moneda", "Devuelve el precio total en centavos", "Devuelve los impuestos", 2, 15),
    
    # Store Configuration & Settings
    ("¿Dónde se configuran las zonas de envío en Shopify?", "Configuración > Pantalla de pago", "Configuración > Envío y entrega", "Configuración > Mercados", "Configuración > Impuestos", 1, 10),
    ("¿Qué es Shopify Payments?", "Una app de terceros", "La pasarela de pago nativa de Shopify", "Un método de envío", "Un plan de suscripción", 1, 10),
    ("Si usas una pasarela de pago externa en lugar de Shopify Payments, ¿qué ocurre?", "Shopify no te deja vender", "Shopify te cobra una comisión adicional por transacción", "Es gratis", "Solo puedes vender en tu país", 1, 20),
    ("¿Para qué sirve el apartado 'Mercados' (Markets) en Shopify?", "Para vender internacionalmente con distintas monedas y precios", "Para comprar temas", "Para contratar expertos", "Para crear colecciones", 0, 15),
    ("¿Qué es un Webhook en Shopify?", "Un gancho para colgar productos", "Una notificación HTTP automática a un servidor cuando ocurre un evento", "Un tema gratuito", "Una extensión de Chrome", 1, 15),
    ("¿Qué lenguaje se usa comúnmente para interactuar con la API REST de Shopify?", "PHP, Node.js, Python, Ruby, etc.", "Solo Liquid", "Solo Ruby", "C++", 0, 10),
    ("¿Shopify soporta GraphQL?", "No, solo REST", "Sí, a través de la API de Admin y Storefront", "Solo en Shopify Plus", "Solo para aplicaciones públicas", 1, 15),
    ("¿Qué permisos se requieren para que una App acceda a los pedidos?", "read_products", "write_themes", "read_orders / write_orders", "read_customers", 2, 15),
    ("¿Qué es el 'Storefront API'?", "La API para modificar el admin", "Una API de GraphQL para crear tiendas headless (personalizadas)", "Una API de facturación", "El editor de temas", 1, 20),
    
    # Themes & Online Store 2.0
    ("¿Qué es Online Store 2.0 (OS 2.0)?", "La segunda versión de Shopify", "La nueva arquitectura de temas que permite bloques y secciones en todas las páginas", "Una actualización de precios", "Un nuevo tema predeterminado", 1, 15),
    ("En OS 2.0, ¿qué formato de archivo se usa para las plantillas principales (ej. product.json)?", ".liquid", ".html", ".json", ".xml", 2, 20),
    ("¿Qué es una 'Sección' en un tema de Shopify?", "Un bloque de código reutilizable que puede ser configurado en el editor de temas", "Un producto", "Un artículo del blog", "Una pasarela de pago", 0, 10),
    ("En el esquema de una sección {% schema %}, ¿qué lenguaje se utiliza?", "XML", "YAML", "JSON", "Markdown", 2, 15),
    ("¿Cómo incluyes una sección estática en Liquid?", "{% include 'header' %}", "{% section 'header' %}", "{% require 'header' %}", "{% load 'header' %}", 1, 15),
    ("¿Qué hace la carpeta 'assets' en un tema de Shopify?", "Guarda los productos", "Guarda los pedidos", "Almacena CSS, JS e imágenes del tema", "Guarda los clientes", 2, 10),
    ("¿Qué hace el filtro | asset_url?", "Genera la URL de un producto", "Devuelve la URL de una imagen en la carpeta assets en el CDN", "Redirige al inicio", "Crea un enlace de pago", 1, 10),
    ("¿Para qué sirve la carpeta 'locales' en un tema?", "Para almacenar direcciones IP", "Para archivos JSON de traducciones (multidioma)", "Para guardar ubicaciones físicas de la tienda", "Para guardar monedas", 1, 15),
    ("¿Qué es un 'Snippet' en Shopify?", "Un pequeño fragmento de código Liquid reutilizable", "Una imagen pequeña", "Un descuento temporal", "Una variante de producto", 0, 10),
    ("¿En qué carpeta se guardan los snippets?", "templates/", "sections/", "snippets/", "assets/", 2, 10),
    ("¿Qué objeto Liquid contiene la información de las metaetiquetas (metafields)?", "product.metafields", "shop.data", "product.custom", "variant.extra", 0, 15),
    
    # SEO & Marketing
    ("¿Dónde modificas el Título SEO de un producto en Shopify?", "En la configuración general", "Al final de la página de edición del producto (Buscadores)", "En el tema Liquid exclusivamente", "En la pasarela de pago", 1, 10),
    ("¿Qué genera Shopify automáticamente para el SEO?", "Sitemap.xml y robots.txt", "Páginas de Wikipedia", "Cuentas de Instagram", "Artículos de blog", 0, 15),
    ("¿Puedes cambiar la estructura de la URL base de un producto (ej. /products/mi-producto)?", "Sí, completamente", "No, el prefijo /products/ es fijo en Shopify", "Solo en Shopify Plus", "Solo instalando una App", 1, 20),
    ("¿Qué formato utiliza Shopify para importar/exportar productos masivamente?", "XML", "JSON", "CSV", "Excel (.xlsx)", 2, 10),
    ("¿Qué es un código de descuento automático?", "Un código que el cliente debe escribir a mano", "Un descuento que se aplica solo en el carrito si se cumplen las condiciones", "Un descuento falso", "Una tarjeta de regalo", 1, 10),
    ("¿Puedes ofrecer envío gratis a través de un código de descuento?", "Sí", "No", "Solo en compras internacionales", "Solo para Shopify Plus", 0, 10),
    ("¿Qué es una tarjeta de regalo (Gift Card) en Shopify?", "Un producto físico que se envía por correo", "Un producto especial cuyo valor se puede usar como método de pago", "Un cupón de descuento de porcentaje", "Una forma de donar a ONGs", 1, 10),
    
    # Blogs & Pages
    ("¿Shopify incluye un sistema de blog integrado?", "Sí", "No", "Solo mediante apps", "Solo en el plan avanzado", 0, 10),
    ("¿Qué objeto Liquid se usa para acceder a un blog?", "news", "article", "blog", "posts", 2, 15),
    ("¿Cómo se llama cada entrada individual de un blog en Shopify?", "post", "article", "entry", "page", 1, 10),
    ("¿Qué diferencia hay entre una 'Página' y un 'Artículo' en Shopify?", "No hay diferencia", "Las páginas son estáticas (ej. Contacto), los artículos pertenecen a un blog y tienen fecha", "Las páginas son de pago, los artículos gratis", "Los artículos solo pueden tener texto", 1, 10),
    ("¿Qué es el objeto 'linklist' en Liquid?", "Una lista de productos", "Un menú de navegación", "Una lista de clientes", "Los enlaces de redes sociales", 1, 15),
    ("¿Cómo se llama el menú principal de navegación por defecto?", "main-menu", "nav", "header-links", "top-menu", 0, 15),
    
    # Customers & Accounts
    ("¿Es obligatorio que los clientes creen una cuenta para comprar?", "Sí, siempre", "No, se puede configurar como opcional, obligatorio o deshabilitado", "No, nunca pueden crear cuentas", "Solo si compran productos digitales", 1, 10),
    ("¿Qué objeto Liquid contiene la información del cliente actual logueado?", "user", "account", "customer", "visitor", 2, 10),
    ("¿Qué etiqueta se usa para verificar si un cliente está logueado?", "{% if customer %}", "{% if user.logged_in %}", "{% if account.active %}", "{% if session.customer %}", 0, 10),
    ("¿Qué información guarda Shopify sobre un cliente?", "Historial de pedidos, direcciones, nombre y email", "Contraseña en texto plano", "Datos de tarjeta de crédito completos", "Su historial de navegación en otros sitios", 0, 10),
    ("¿Qué son los 'Tags' de cliente?", "Etiquetas para segmentar clientes (ej. VIP, Mayorista)", "Nombres de usuario", "Las contraseñas cifradas", "Los productos que ha comprado", 0, 10),

    # Advanced Liquid & Logic
    ("¿Qué hace el operador 'contains' en Liquid?", "Suma dos variables", "Comprueba si un string o array incluye una subcadena o elemento", "Comprueba si una variable existe", "Concatena strings", 1, 15),
    ("Si quieres mostrar los primeros 3 productos de una colección, ¿qué filtro o parámetro usas en el for?", "{% for p in collection limit:3 %}", "{% for p in collection max:3 %}", "{% for p in collection stop:3 %}", "{% for p in collection first:3 %}", 0, 15),
    ("¿Qué es 'paginate' en Liquid?", "Un filtro para cortar texto", "Un bloque para dividir grandes colecciones de productos en múltiples páginas", "Un objeto de orden", "Un tipo de menú", 1, 15),
    ("¿Qué hace el filtro 'default'?", "Establece un valor por defecto si la variable está vacía o no existe", "Elimina la variable", "Muestra un error", "Convierte la variable a string", 0, 10),
    ("¿Cómo se escribe un bloque 'else if' en Liquid?", "{% elseif %}", "{% else if %}", "{% elsif %}", "{% elif %}", 2, 15),
    ("¿Qué filtro usarías para convertir una fecha a un formato legible?", "time", "date", "format_date", "strftime", 1, 10),
    ("¿Qué devuelve el filtro 'handleize'?", "Convierte un texto en un formato amigable para URL (minúsculas, guiones)", "Crea un producto nuevo", "Devuelve el ID", "Borra los espacios", 0, 15),
    ("¿Cómo obtienes el primer elemento de un array en Liquid?", "array.0", "array[1]", "array.first", "first(array)", 2, 10),
    ("¿Qué hace el filtro 'strip_html'?", "Añade etiquetas HTML", "Borra todo el texto", "Elimina todas las etiquetas HTML de un string", "Convierte texto a HTML", 2, 10),
    ("¿Qué es un 'Metafield' en Shopify?", "Un campo personalizado para añadir información extra a productos, clientes o pedidos", "Un campo de fuerza", "Una etiqueta HTML", "Una regla de envío", 0, 15),

    # Apps & Integrations
    ("¿Dónde descargas aplicaciones oficiales para Shopify?", "Google Play", "App Store de Apple", "Shopify App Store", "En el editor de temas", 2, 10),
    ("¿Qué es una 'Custom App' (App Personalizada) en Shopify?", "Una app que está en la App Store", "Una app desarrollada específicamente para una tienda y que no se publica en la App Store", "Una app de diseño visual", "Un tema a medida", 1, 15),
    ("¿Qué son los App Blocks en OS 2.0?", "Bloques de construcción de plástico", "Permiten a las apps inyectar código visualmente en el tema sin modificar los archivos Liquid directamente", "Bloqueadores de anuncios", "Apps que bloquean fraudes", 1, 20),
    ("¿Qué plataforma recomienda Shopify para desplegar aplicaciones customizadas modernas?", "No importa, se pueden alojar en cualquier servidor externo (AWS, Heroku, Fly.io, etc.)", "Shopify Hosting", "Shopify Plus Servers", "Solo en servidores locales", 0, 15),
    ("¿Qué es Shopify CLI?", "Una interfaz de línea de comandos para construir temas y apps de Shopify rápidamente", "Un lenguaje de programación", "Una pasarela de pago", "Un tema gratuito", 0, 15),
    ("¿Qué comando se usa para iniciar sesión en Shopify CLI?", "shopify login", "shopify auth", "shopify start", "shopify theme dev", 0, 15),

    # General Knowledge
    ("¿En qué lenguaje está escrito el núcleo del backend de Shopify?", "PHP", "Node.js", "Ruby on Rails", "Java", 2, 20),
    ("¿Qué tipo de plataforma es Shopify?", "IaaS (Infrastructure as a Service)", "SaaS (Software as a Service)", "Open Source descargable", "Un plugin de WordPress", 1, 10),
    ("¿Shopify ofrece hosting web incluido en sus planes?", "No, debes pagar un hosting aparte", "Sí, todas las tiendas Shopify incluyen hosting seguro ilimitado", "Solo para las imágenes", "Solo en Shopify Plus", 1, 10),
    ("¿Qué es Shopify POS?", "Point of Sale, un sistema para vender en tiendas físicas sincronizado con la tienda online", "Un tipo de producto", "Un impuesto sobre ventas", "Position of Store", 0, 10),
    ("¿Qué hace el canal de ventas 'Shop'? ", "Es la aplicación móvil para consumidores donde pueden rastrear paquetes y descubrir tiendas Shopify", "Es el panel de administrador", "Es un proveedor de dominios", "Es la API de pagos", 0, 10),
    ("¿Se puede exportar el código fuente completo del backend de una tienda Shopify?", "Sí", "No, Shopify es código cerrado, solo puedes exportar los datos y el Tema", "Solo en Shopify Plus", "Sí, a través de FTP", 1, 15),
    ("¿Qué hace la función 'Borrador de Pedido' (Draft Order)?", "Elimina un pedido", "Permite al comerciante crear un pedido manualmente y enviar una factura al cliente", "Oculta el pedido del cliente", "Devuelve el dinero", 1, 15),
    ("¿Qué es el 'Centro de Ayuda' (Help Center) de Shopify?", "El lugar donde están todos los tutoriales y documentación oficial para comerciantes", "Un foro de hackers", "El panel de control", "Una aplicación de chat", 0, 10),

    # Let's add more to reach around 100...
    ("¿Qué es el objeto 'request' en Liquid?", "Un objeto que contiene detalles de la solicitud web actual (ej. path, page_type)", "Una petición de amistad", "Una consulta a base de datos", "Un webhook", 0, 15),
    ("¿Cómo imprimes la URL de la página actual en Liquid?", "{{ request.path }}", "{{ url }}", "{{ current_url }}", "{{ page.url }}", 0, 15),
    ("¿Qué objeto contiene los enlaces de redes sociales si el tema lo soporta?", "settings", "social", "links", "No existe un objeto estándar único, depende del settings_schema del tema", 3, 20),
    ("¿Qué es un 'Redirect' (Redireccionamiento) en Shopify?", "Un cambio de color de la web", "Una regla para enviar a los usuarios de una URL antigua a una nueva (ej. error 404 a otra página)", "Un reembolso automático", "Un código de envío gratis", 1, 10),
    ("¿Dónde gestionas los redireccionamientos URL en Shopify?", "Tienda Online > Navegación > Redireccionamientos de URL", "Configuración > Archivos", "Productos > Redirecciones", "En el código Liquid", 0, 15),
    ("¿Qué límite de productos tiene Shopify en sus planes estándar?", "100", "10,000", "100,000", "Ilimitado", 3, 10),
    ("¿Qué es un 'Staff Member' (Empleado) en Shopify?", "Un cliente VIP", "Un usuario con acceso al panel de administración de la tienda", "Un bot de soporte", "Un proveedor", 1, 10),
    ("¿Qué son las 'Ubicaciones' (Locations) en Shopify?", "Los idiomas de la tienda", "Lugares físicos o aplicaciones donde se gestiona inventario y se preparan pedidos", "Las direcciones de los clientes", "Las zonas de envío", 1, 10),
    ("¿Puedes restringir ciertos productos a ciertos países sin apps de terceros?", "Sí, nativamente mediante Shopify Markets", "No, es imposible", "Solo borrando el producto", "Solo con Shopify Plus", 0, 20),
    ("¿Qué hace la aplicación 'Shopify Inbox'?", "Gestiona correos de marketing", "Permite chatear con los clientes en vivo desde la tienda", "Filtra spam", "Importa productos", 1, 10),
    
    # Liquid specific advanced
    ("¿Qué hace el filtro 'where' en Liquid?", "Crea una consulta SQL", "Filtra un array de objetos según el valor de una propiedad", "Busca en Google", "Redirige a otra página", 1, 15),
    ("¿Qué hace el filtro 'map'?", "Muestra un mapa de Google", "Extrae una propiedad específica de todos los objetos en un array", "Ubica la tienda", "Convierte un string a un array", 1, 15),
    ("¿Cómo unes los elementos de un array en un solo string en Liquid?", "join", "concat", "merge", "bind", 0, 10),
    ("¿Qué hace el filtro 'split'?", "Divide una cadena en un array basado en un separador", "Parte un producto en dos", "Corta una imagen", "Divide el precio", 0, 10),
    ("¿Qué es el objeto 'all_products'?", "Un objeto global para acceder a cualquier producto por su handle, aunque está limitado a 20 usos por página", "Una lista ilimitada de todos los productos de la tienda", "Un comando para borrar todos los productos", "Una colección automática", 0, 20)
]

# Write to a SQL file
sql_statements = []
for q in questions:
    question_text = q[0].replace("'", "''")
    o0 = q[1].replace("'", "''")
    o1 = q[2].replace("'", "''")
    o2 = q[3].replace("'", "''")
    o3 = q[4].replace("'", "''")
    ans = q[5]
    xp = q[6]
    
    sql_statements.append(f"INSERT INTO questions (question_text, option_0, option_1, option_2, option_3, correct_answer_index, xp_reward) VALUES ('{question_text}', '{o0}', '{o1}', '{o2}', '{o3}', {ans}, {xp});")

with open('seed_100_questions.sql', 'w', encoding='utf-8') as f:
    f.write("\n".join(sql_statements))

print("SQL generated with", len(questions), "questions.")
