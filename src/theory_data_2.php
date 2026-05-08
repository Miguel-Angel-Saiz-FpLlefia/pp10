<?php
$topics_2 = [
    "descuentos-automaticos" => [
        "title" => "Descuentos Automáticos",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Conversión sin Fricción</h2>
            <p class='mb-4'>A diferencia de los cupones que el usuario debe buscar y escribir en el checkout (lo que causa salidas hacia Google buscando 'cupones de descuento'), los descuentos automáticos se aplican solos en el carrito cuando se cumplen condiciones lógicas.</p>
            <h3 class='text-xl font-bold mb-2'>Ejemplos de Aplicación</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Volumen:</strong> 20% OFF en todos los accesorios al comprar un ordenador.</li>
                <li><strong>Flash Sales:</strong> Todos los productos de la colección 'Invierno' rebajados sin usar el campo de 'precio comparado' producto a producto.</li>
            </ul>
        "
    ],
    "tarjetas-regalo" => [
        "title" => "Tarjetas de Regalo (Gift Cards)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Micro-economía del E-commerce</h2>
            <p class='mb-4'>Las Gift Cards en Shopify se comportan como un producto pero no generan un revenue real hasta que son canjeadas (principio contable de pasivo diferido). Se envían por email con un código único y pueden ser agregadas a Apple Wallet.</p>
            <p><strong>Casos de desarrollo:</strong> Si usas la API de Admin, puedes emitir Gift Cards masivamente como compensación a clientes en lugar de emitir un reembolso de dinero a la tarjeta (mejorando el Cash Flow).</p>
        "
    ],
    "marketing-basico" => [
        "title" => "Marketing y Retención",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Ciclo de Vida del Cliente</h2>
            <p class='mb-4'>El coste de adquisición (CAC) es alto. La rentabilidad viene de la retención. Shopify incluye herramientas nativas como Shopify Email (gratis hasta 10,000 correos al mes) para enviar newsletters directamente desde el panel.</p>
            <h3 class='text-xl font-bold mb-2'>Automatizaciones Base</h3>
            <p>El flujo más crítico es el de <strong>Carrito Abandonado</strong>. Si un usuario introduce su email en el checkout pero no paga, Shopify retiene esa sesión y puede enviar un correo a las 10 horas ofreciendo un 5% de descuento para cerrar la venta.</p>
        "
    ],
    "seo-basico" => [
        "title" => "SEO Técnico en Shopify",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Visibilidad Orgánica</h2>
            <p class='mb-4'>Shopify auto-genera y mantiene los archivos <code>sitemap.xml</code> y <code>robots.txt</code>. Permite editar libremente el Title, Meta Description y URL Handle de cada recurso.</p>
            <h3 class='text-xl font-bold mb-2'>Consideraciones Estructurales</h3>
            <p>Las URLs en Shopify tienen un formato rígido. Un producto siempre estará en <code>/products/nombre</code> y una colección en <code>/collections/nombre</code>. Un error común es enlazar a un producto *dentro* de una colección (<code>/collections/zapatos/products/zapato1</code>) lo que genera contenido duplicado a ojos de Google. Como desarrollador, debes asegurarte que el tema enlaza usando el filtro de Liquid <code>within: collection</code> con cuidado o mejor, forzar URLs canónicas.</p>
        "
    ],
    "redirecciones-301" => [
        "title" => "Redirecciones 301",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Migraciones Sin Dolor</h2>
            <p class='mb-4'>Cuando un cliente migra de Prestashop a Shopify, sus URLs antiguas dejarán de funcionar (Error 404), perdiendo todo su posicionamiento en Google.</p>
            <p>En <em>Navegación > Redirecciones de URL</em>, puedes importar un CSV que le diga a Shopify: 'Si alguien entra a <code>/catalogo.php?id=12</code>, redirígelo permanentemente (Código 301) a <code>/products/zapatilla-nike</code>'. Esto traspasa la autoridad del enlace (Link Juice).</p>
        "
    ],
    "analitica-reportes" => [
        "title" => "Analítica y Reportes",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Business Intelligence</h2>
            <p class='mb-4'>Shopify centraliza los datos (sesiones, ventas por UTMs de campañas, retornos, CAC). La métrica reina es la <strong>Tasa de Conversión (CR)</strong>, que mide el % de sesiones que acaban en compra (promedio sector 1.5% - 2.5%).</p>
            <h3 class='text-xl font-bold mb-2'>Integraciones</h3>
            <p>Aunque el panel de Shopify es robusto, siempre debe complementarse con Google Analytics 4 (mediante la app nativa de Google Channel) para analizar mapas de calor, flujos de navegación complejos y comportamiento de abandono de embudo detallado.</p>
        "
    ],
    "liquid-sintaxis" => [
        "title" => "Liquid: Sintaxis Básica",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>El Lenguaje del Frontend</h2>
            <p class='mb-4'>Liquid es un motor de plantillas de código abierto creado por Shopify escrito originalmente en Ruby. No es PHP, se ejecuta en el servidor y devuelve HTML puro.</p>
            <h3 class='text-xl font-bold mb-2'>Bloques Principales</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Output (Doble llave):</strong> <code>{{ product.title }}</code> -> Imprime el título del producto.</li>
                <li><strong>Tags (Llave y porcentaje):</strong> <code>{% if user %} Hola {% endif %}</code> -> Ejecuta lógica (condicionales, bucles).</li>
                <li><strong>Filtros (Barra vertical):</strong> <code>{{ 'hola' | upcase }}</code> -> Transforma el output a 'HOLA'.</li>
            </ul>
        "
    ],
    "liquid-filtros" => [
        "title" => "Liquid: Filtros Avanzados",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Manipulación de Datos al Vuelo</h2>
            <p class='mb-4'>Los filtros permiten procesar la información directamente en la plantilla sin requerir lógica en el backend.</p>
            <h3 class='text-xl font-bold mb-2'>Filtros Clave</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Dinero:</strong> <code>{{ product.price | money_with_currency }}</code> (Formatea el entero a ej. '29,99 € EUR').</li>
                <li><strong>Imágenes:</strong> <code>{{ product.featured_image | image_url: width: 400 }}</code> (Pide al CDN de Shopify que genere y sirva una versión optimizada de 400px en formato WebP dinámicamente).</li>
                <li><strong>Arrays:</strong> <code>map</code>, <code>join</code>, <code>sort</code>, <code>where</code> para extraer y manipular listas complejas de objetos.</li>
            </ul>
        "
    ],
    "liquid-bucles" => [
        "title" => "Liquid: Iteración",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Manejo de Listas y Paginate</h2>
            <p class='mb-4'>Para mostrar productos, iteramos sobre colecciones usando bucles <code>for</code>.</p>
            <pre class='bg-gray-800 text-green-400 p-4 rounded mb-4'><code>
{% paginate collection.products by 12 %}
  {% for product in collection.products %}
    &lt;!-- Render Product Card --&gt;
  {% endfor %}
  {{ paginate | default_pagination }}
{% endpaginate %}
            </code></pre>
            <p><strong>Límite crítico:</strong> Shopify restringe las colecciones a un máximo de 50 elementos devueltos por llamada. Si no envuelves el bucle en un bloque <code>paginate</code>, la página se romperá o solo mostrará los primeros 50.</p>
        "
    ],
    "os2-arquitectura" => [
        "title" => "Online Store 2.0 (OS 2.0)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>La Nueva Era Temática</h2>
            <p class='mb-4'>Antes de 2021, solo la página de inicio (Homepage) podía tener bloques arrastrables (Secciones). OS 2.0 cambió la arquitectura: ahora las plantillas no son archivos <code>.liquid</code>, son archivos <code>.json</code> que mapean qué secciones van en qué orden.</p>
            <p>Esto permite a los comerciantes construir páginas completas (Acerca de, FAQ, Landing Pages) usando bloques visuales sin necesitar a un desarrollador para cada pequeño cambio estructural.</p>
        "
    ],
    "os2-secciones" => [
        "title" => "Desarrollo de Secciones (Sections)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Componentes Reutilizables</h2>
            <p class='mb-4'>Una sección es un archivo Liquid autónomo. El 'secreto' es la etiqueta <code>{% schema %}</code>, que define la interfaz en el Theme Editor.</p>
            <pre class='bg-gray-800 text-yellow-300 p-4 rounded mb-4 text-sm'><code>
{% schema %}
{
  \"name\": \"Hero Banner\",
  \"settings\": [
    { \"type\": \"text\", \"id\": \"title\", \"label\": \"Título principal\" },
    { \"type\": \"image_picker\", \"id\": \"bg_image\", \"label\": \"Fondo\" }
  ]
}
{% endschema %}
            </code></pre>
            <p>Lo que definas en este JSON, aparecerá como controles visuales (cajas de texto, selectores de color) para el administrador de la tienda, y podrás leer esos valores en el HTML usando <code>{{ section.settings.title }}</code>.</p>
        "
    ],
    "os2-app-blocks" => [
        "title" => "App Blocks y Theme App Extensions",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Ecosistema Limpio</h2>
            <p class='mb-4'>El mayor problema histórico de Shopify era la desinstalación de Apps. Las apps inyectaban código sucio en los archivos del tema, y al desinstalarse, dejaban 'basura' que ralentizaba la web.</p>
            <p><strong>Theme App Extensions</strong> resuelven esto. Ahora las apps proveen 'Bloques' que el usuario arrastra visualmente en el editor. El código de la app vive aislado. Si se desinstala la app, el bloque desaparece automáticamente sin dejar rastro en el código fuente de la tienda.</p>
        "
    ],
    "shopify-cli" => [
        "title" => "Shopify CLI y Entorno Local",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Herramientas de Desarrollador</h2>
            <p class='mb-4'>Shopify CLI es un paquete Node.js (se ejecuta en tu terminal con <code>shopify theme dev</code>) que permite:</p>
            <ul class='list-disc pl-5 mb-4'>
                <li>Crear un túnel seguro (Cloudflare) para ver tu código local ejecutándose contra los datos reales (productos, colecciones) de la base de datos de producción de la tienda.</li>
                <li>Hot-reloading instantáneo de CSS y Liquid en tu navegador mientras programas.</li>
                <li>Desplegar cambios directamente (<code>shopify theme push</code>) sin usar el antiguo y lento Theme Kit.</li>
            </ul>
        "
    ],
    "github-integration" => [
        "title" => "Integración con GitHub",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>CI/CD Nativo en Shopify</h2>
            <p class='mb-4'>Puedes conectar un repositorio de GitHub al panel de administración de Shopify. Cada rama (branch) se convertirá en un tema previsualizable oculto en la tienda.</p>
            <p>Cuando un desarrollador hace <code>git push origin main</code>, Shopify detecta el webhook de GitHub y actualiza automáticamente el código del tema principal en milisegundos, permitiendo un flujo de trabajo profesional con Pull Requests y Code Review antes de ir a producción.</p>
        "
    ],
    "hydrogen-oxygen" => [
        "title" => "Hydrogen y Oxygen (Headless)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>El Futuro Desacoplado</h2>
            <p class='mb-4'><strong>Hydrogen</strong> es el stack Headless de Shopify. Basado en <em>Remix</em> (framework de React), permite crear tiendas súper rápidas e interactivas que no usan Liquid en absoluto, leyendo datos directamente de la Storefront API vía GraphQL.</p>
            <p><strong>Oxygen</strong> es la plataforma de hosting global (basada en Workers) construida por Shopify para alojar estas aplicaciones Hydrogen gratuitamente, resolviendo el histórico problema de tener que pagar a Vercel o Netlify para alojar frontends Headless de tiendas Shopify.</p>
        "
    ],
    "storefront-api" => [
        "title" => "Storefront API (GraphQL)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>La API Pública</h2>
            <p class='mb-4'>Es un endpoint de GraphQL diseñado para no requerir autenticación de servidor a servidor. Usa un token público.</p>
            <h3 class='text-xl font-bold mb-2'>¿Para qué se usa?</h3>
            <p>Para construir experiencias de compra fuera del entorno tradicional web: aplicaciones móviles nativas (iOS/Android), integraciones en videojuegos (ej. comprar merchandising sin salir de Fortnite), o para construir un frontend a medida con React, Vue o Svelte.</p>
        "
    ],
    "admin-api-rest" => [
        "title" => "Admin API (Rest y GraphQL)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>El Control Total</h2>
            <p class='mb-4'>Esta API es privada y requiere autenticación segura (Tokens o OAuth). Permite leer, crear y borrar cualquier dato del backend de la tienda (inventario, pedidos, reportes, reembolsos).</p>
            <h3 class='text-xl font-bold mb-2'>REST vs GraphQL</h3>
            <p>Shopify mantiene su API REST por retrocompatibilidad, pero <strong>GraphQL es obligatorio</strong> para acceder a nuevas funcionalidades (como bulk operations o Metaobjects). GraphQL soluciona el problema de tener que hacer 10 peticiones HTTP (REST) para obtener datos anidados (Over-fetching).</p>
        "
    ],
    "webhooks-eventos" => [
        "title" => "Webhooks y Eventos",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Arquitectura Orientada a Eventos</h2>
            <p class='mb-4'>Un Webhook permite que tu servidor reciba una notificación (payload JSON) en tiempo real en lugar de tener que consultar la API (polling) constantemente.</p>
            <p><strong>Ejemplo:</strong> Registras el evento <code>orders/create</code>. Cuando un cliente compra, Shopify dispara un POST a tu URL (ej. <code>mi-erp.com/shopify-webhook</code>). Tu servidor lo procesa de inmediato. Es crítico validar el header <code>X-Shopify-Hmac-Sha256</code> para asegurar que el mensaje es realmente de Shopify y no de un hacker.</p>
        "
    ],
    "custom-apps" => [
        "title" => "Custom Apps",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Desarrollo Privado</h2>
            <p class='mb-4'>Las Custom Apps se instalan directamente en una tienda específica a través del panel de administración (Settings > Apps and Sales Channels). No requieren revisión pública por parte de Shopify.</p>
            <p>Se usan principalmente para construir conectores B2B a medida, integraciones con sistemas contables locales, o dashboards internos especializados que consumen la Admin API mediante un 'Access Token' generado permanentemente.</p>
        "
    ],
    "public-apps" => [
        "title" => "Public Apps y App Store",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Desarrollo SaaS B2B</h2>
            <p class='mb-4'>Crear una app para vender a miles de comerciantes requiere un nivel técnico mayor.</p>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>OAuth 2.0:</strong> La instalación requiere redirigir al comerciante, pedir permisos (ej. leer productos) e intercambiar un código por un token de sesión.</li>
                <li><strong>Billing API:</strong> Tienes que integrarte con el motor de cobros de Shopify (cargos recurrentes, freemium) para que Shopify le cobre al comerciante en su factura mensual y luego te transfiera tu parte.</li>
                <li><strong>Proceso de Revisión:</strong> Shopify probará la app exhaustivamente antes de admitirla en la tienda de aplicaciones.</li>
            </ul>
        "
    ],
    "shopify-flow" => [
        "title" => "Shopify Flow (Automatizaciones)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>No-Code Logic</h2>
            <p class='mb-4'>Shopify Flow es un constructor visual de lógicas empresariales. Sigue la estructura: <strong>Trigger</strong> (Disparador), <strong>Condition</strong> (Condición), <strong>Action</strong> (Acción).</p>
            <p><strong>Ejemplos Reales:</strong></p>
            <ul class='list-disc pl-5 mb-4'>
                <li>Si el stock de un producto baja de 10 unidades -> Enviar Slack a Compras y pausar anuncios en Google Ads.</li>
                <li>Si un pedido es marcado como 'Alto riesgo de Fraude' -> Cancelar pedido, hacer reembolso automático, y etiquetar al cliente como bloqueado.</li>
            </ul>
            <p>Los desarrolladores pueden construir conectores (App Actions) para que Flow pueda integrarse con sus propias aplicaciones.</p>
        "
    ],
    "shopify-functions" => [
        "title" => "Shopify Functions (WASM/Rust)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Extensibilidad del Backend</h2>
            <p class='mb-4'>Las Functions reemplazan a los antiguos <em>Shopify Scripts</em>. Permiten ejecutar código personalizado a nivel de servidor <strong>dentro</strong> de la infraestructura hiper-rápida de Shopify.</p>
            <p>Los programadores escriben la lógica de descuentos complejos o reglas logísticas en <strong>Rust, C++ o Javascript (Javy)</strong>, lo compilan a WebAssembly (WASM) y lo suben. Estas funciones se ejecutan en milisegundos durante el checkout sin introducir latencia, solucionando necesidades complejas de descuentos (ej. \"3x2 si el producto es de esta marca y el usuario es VIP tier 2\").</p>
        "
    ],
    "pixels-tracking" => [
        "title" => "Web Pixel Manager y Tracking",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Seguridad en la Analítica</h2>
            <p class='mb-4'>Históricamente, los píxeles de Facebook, Google y TikTok se inyectaban en el <code>theme.liquid</code>, accediendo indiscriminadamente a todo el DOM y comprometiendo el rendimiento y la privacidad.</p>
            <p>Shopify introdujo una API unificada (Customer Events). Los píxeles corren en un <strong>entorno Web Worker aislado (Sandbox)</strong>. Ya no pueden acceder a la página web real, sino que se suscriben a eventos emitidos por Shopify de forma estandarizada (<code>checkout_completed</code>, <code>product_viewed</code>), aumentando la velocidad de carga de la web y el cumplimiento de leyes como la RGPD.</p>
        "
    ],
    "optimizacion-rendimiento" => [
        "title" => "Optimización de Rendimiento",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Core Web Vitals</h2>
            <p class='mb-4'>La velocidad impacta directamente al SEO y la conversión. Las responsabilidades de un desarrollador Shopify experto incluyen:</p>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>LCP (Largest Contentful Paint):</strong> Precargar (<code>preload</code>) la imagen principal del producto y desactivar el 'lazy loading' en el LCP.</li>
                <li><strong>CLS (Cumulative Layout Shift):</strong> Definir siempre <code>width</code> y <code>height</code> de las imágenes (usando el atributo <code>aspect-ratio</code> de CSS) para reservar el espacio antes de que carguen.</li>
                <li><strong>Limpieza de Apps:</strong> Evaluar impactos y desactivar scripts sobrantes.</li>
            </ul>
        "
    ],
    "seguridad-fraude" => [
        "title" => "Seguridad y Análisis de Fraude",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Protección contra Chargebacks</h2>
            <p class='mb-4'>Los fraudes en tarjetas de crédito son el mayor agujero económico del comercio B2C. Shopify integra un motor de análisis de fraude automático usando Machine Learning.</p>
            <p>Verifica disparidades como que la IP sea de Rusia, pero la dirección de entrega en España, o que el CVV esté ausente pero la transacción haya pasado (común en robos masivos de tarjetas). Un comerciante o un script de automatización pueden decidir rechazar estos pagos antes de enviarlos, previniendo así un 'Chargeback' del banco que conlleva tarifas punitivas de 15$ a 30$.</p>
        "
    ]
];
