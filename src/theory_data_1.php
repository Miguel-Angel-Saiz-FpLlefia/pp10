<?php
$topics_1 = [
    "intro-ecommerce" => [
        "title" => "Introducción al E-commerce y Shopify",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>El Ecosistema del E-commerce</h2>
            <p class='mb-4'>El comercio electrónico moderno exige plataformas robustas. Shopify opera bajo un modelo <strong>SaaS (Software as a Service)</strong>. Esto significa que, a diferencia de Magento o WooCommerce (que requieren hosting, mantenimiento de servidores y actualizaciones de seguridad manuales), Shopify se encarga de toda la infraestructura.</p>
            <h3 class='text-xl font-bold mb-2'>Ventajas Competitivas</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Escalabilidad:</strong> Soporta desde 1 hasta 10,000 transacciones por minuto sin caídas.</li>
                <li><strong>Seguridad Nivel 1 PCI DSS:</strong> Todo el procesamiento de tarjetas está asegurado de forma nativa.</li>
                <li><strong>CDN Global:</strong> Utiliza Fastly y Cloudflare para servir imágenes y código estático desde el servidor más cercano al cliente.</li>
            </ul>
        "
    ],
    "arquitectura-shopify" => [
        "title" => "Arquitectura de Shopify",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Infraestructura Subyacente</h2>
            <p class='mb-4'>Shopify está construido principalmente sobre <strong>Ruby on Rails</strong> con bases de datos MySQL, aunque su arquitectura ha evolucionado hacia microservicios utilizando Go y Rust para componentes críticos de rendimiento.</p>
            <h3 class='text-xl font-bold mb-2'>Componentes Clave</h3>
            <div class='bg-gray-100 p-4 rounded mb-4'>
                <p><strong>El Monolito Core:</strong> Gestiona la lógica de negocio principal, el checkout y la interfaz de administración.</p>
                <p><strong>Storefront API:</strong> Capa GraphQL escrita en Go que sirve los datos a velocidades ultrarrápidas, utilizada por Hydrogen y aplicaciones móviles.</p>
            </div>
            <p>Comprender esta arquitectura es vital para no saturar la API con llamadas ineficientes.</p>
        "
    ],
    "planes-precios" => [
        "title" => "Planes y Precios de Shopify",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Estructura de Costes</h2>
            <p class='mb-4'>Elegir el plan adecuado depende del volumen de ventas. Shopify ofrece:</p>
            <ul class='list-disc pl-5 mb-4 space-y-2'>
                <li><strong>Basic:</strong> Ideal para empezar. Incluye 2 cuentas de empleado y comisiones de transacción más altas (aprox. 2.9% + 30¢ si no usas Shopify Payments).</li>
                <li><strong>Shopify:</strong> Añade reportes profesionales y reduce la comisión.</li>
                <li><strong>Advanced:</strong> Para negocios en crecimiento rápido. Mejores tasas y cálculo de envíos por terceros.</li>
                <li><strong>Shopify Plus:</strong> Nivel Enterprise (desde $2,000/mes). Incluye Checkout Extensibility, B2B, Launchpad y cuentas ilimitadas.</li>
            </ul>
        "
    ],
    "configuracion-inicial" => [
        "title" => "Configuración Inicial de la Tienda",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Los Primeros Pasos</h2>
            <p class='mb-4'>Antes de añadir productos, la configuración base debe estar impecable. Esto incluye:</p>
            <h3 class='text-xl font-bold mb-2 text-indigo-700'>Ajustes Generales</h3>
            <p class='mb-4'>En <em>Configuración > Información de la tienda</em> debes definir el formato de moneda (con o sin decimales) y los prefijos de pedido (ej. #ESP-1001) para integrarlos correctamente con el ERP.</p>
            <h3 class='text-xl font-bold mb-2 text-indigo-700'>Políticas Legales</h3>
            <p>Shopify permite generar plantillas automáticas para Política de Privacidad, Términos del Servicio y Política de Devoluciones. Estas páginas deben enlazarse obligatoriamente en el footer del tema por motivos legales.</p>
        "
    ],
    "gestion-dominios" => [
        "title" => "Gestión de Dominios",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Configuración DNS y SSL</h2>
            <p class='mb-4'>Tu tienda incluye un dominio <em>.myshopify.com</em> gratuito que no debe indexarse en buscadores. Para conectar un dominio personalizado:</p>
            <pre class='bg-gray-800 text-green-400 p-4 rounded mb-4'><code>
Registro A   -> Apunta a la IP de Shopify (23.227.38.65)
Registro CNAME -> Apunta a shops.myshopify.com (para el subdominio www)
            </code></pre>
            <p>Shopify genera automáticamente <strong>certificados SSL</strong> mediante Let's Encrypt. Como desarrollador, asegúrate de forzar la redirección del tráfico HTTP a HTTPS marcando el dominio como 'Principal' en el admin.</p>
        "
    ],
    "productos-variantes" => [
        "title" => "Productos y Variantes",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Estructura del Catálogo</h2>
            <p class='mb-4'>Cada producto en Shopify puede tener hasta <strong>3 opciones</strong> (ej. Tamaño, Color, Material) y un límite estricto de <strong>100 variantes</strong>.</p>
            <h3 class='text-xl font-bold mb-2'>Componentes de una Variante</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>SKU:</strong> Obligatorio para control de inventario.</li>
                <li><strong>Barcode (GTIN/UPC):</strong> Necesario para integraciones con Google Shopping y Amazon.</li>
                <li><strong>Inventory Item:</strong> Objeto que enlaza la variante con ubicaciones físicas.</li>
            </ul>
            <p>Si un producto requiere más de 100 variantes, debes usar apps de terceros (Product Options) o separar el producto usando Metaobjects.</p>
        "
    ],
    "colecciones-manuales" => [
        "title" => "Colecciones Manuales",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Curación de Productos</h2>
            <p class='mb-4'>Las colecciones manuales permiten agrupar productos seleccionándolos uno por uno. Son ideales para:</p>
            <ul class='list-disc pl-5 mb-4'>
                <li>Campañas estacionales (ej. 'Rebajas de Verano').</li>
                <li>Lookbooks o colecciones cápsula muy específicas.</li>
            </ul>
            <h3 class='text-xl font-bold mb-2'>Ordenación Personalizada</h3>
            <p>A diferencia de las automatizadas, las colecciones manuales permiten el arrastrar y soltar (drag & drop) para elegir exactamente en qué orden aparecen los productos en el frontend, lo cual es crucial para estrategias de merchandising visual.</p>
        "
    ],
    "colecciones-automatizadas" => [
        "title" => "Colecciones Automatizadas",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Escalabilidad del Catálogo</h2>
            <p class='mb-4'>Las colecciones automatizadas añaden productos basándose en reglas condicionales, eliminando el trabajo manual en catálogos grandes.</p>
            <h3 class='text-xl font-bold mb-2'>Reglas Comunes</h3>
            <pre class='bg-gray-800 text-blue-300 p-4 rounded mb-4'><code>
1. Etiqueta del producto ES IGUAL A 'novedad'
2. Precio del producto ES MAYOR QUE 50
3. Inventario disponible ES MAYOR QUE 0
            </code></pre>
            <p><strong>Nota técnica:</strong> Las condiciones pueden configurarse para cumplir <em>todas</em> (AND) o <em>cualquier</em> condición (OR). Es la base del SEO estructurado en grandes e-commerce.</p>
        "
    ],
    "inventario-ubicaciones" => [
        "title" => "Inventario y Ubicaciones",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Gestión Omnicanal</h2>
            <p class='mb-4'>Shopify permite rastrear inventario en múltiples <strong>Locations</strong> (tiendas físicas, almacenes o centros logísticos externos).</p>
            <h3 class='text-xl font-bold mb-2'>Prioridad de Fulfillment</h3>
            <p class='mb-4'>Cuando entra un pedido, el algoritmo de Shopify decide desde qué almacén descontar el stock basándose en las reglas de enrutamiento (Order Routing).</p>
            <p>Como desarrollador, cuando consultas la disponibilidad en Liquid, <code>product.available</code> verifica todas las ubicaciones. Si necesitas verificar el stock en una tienda específica para Click & Collect, usarás la Storefront API.</p>
        "
    ],
    "etiquetas-tags" => [
        "title" => "Sistema de Etiquetas (Tags)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Metadatos Flexibles</h2>
            <p class='mb-4'>Los tags son cadenas de texto simples que se pueden añadir a Productos, Pedidos, Clientes y Artículos de Blog.</p>
            <h3 class='text-xl font-bold mb-2'>Casos de Uso Principales</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Productos:</strong> Filtros en la barra lateral del catálogo (ej. tag 'material-cuero').</li>
                <li><strong>Clientes:</strong> Asignar niveles VIP (ej. tag 'mayorista') para alterar precios vía Liquid.</li>
                <li><strong>Pedidos:</strong> Marcar pedidos fraudulentos o que requieren revisión manual.</li>
            </ul>
            <p>Tienen un límite estricto de 250 tags por producto y no admiten estructuras clave-valor (para eso usamos Metafields).</p>
        "
    ],
    "metafields-intro" => [
        "title" => "Introducción a los Metafields",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Extensión de Datos Nativos</h2>
            <p class='mb-4'>Los metafields son la respuesta de Shopify para almacenar información estructurada adicional que no viene por defecto en la plataforma.</p>
            <h3 class='text-xl font-bold mb-2'>Estructura de un Metafield</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Namespace:</strong> Agrupación lógica (ej. <code>instrucciones</code>).</li>
                <li><strong>Key:</strong> Identificador (ej. <code>lavado</code>).</li>
                <li><strong>Type:</strong> Tipo de dato (String, Integer, Color, JSON).</li>
            </ul>
            <pre class='bg-gray-800 text-pink-400 p-4 rounded mb-4'><code>
{{ product.metafields.instrucciones.lavado.value }}
            </code></pre>
            <p>Se pueden conectar directamente con el Theme Editor usando Fuentes Dinámicas (Dynamic Sources) en OS 2.0.</p>
        "
    ],
    "metaobjects-intro" => [
        "title" => "Metaobjects: Tablas Personalizadas",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Base de Datos Relacional en Shopify</h2>
            <p class='mb-4'>A diferencia de los Metafields (que se unen a un producto específico), los <strong>Metaobjects</strong> son entidades independientes. Actúan como tablas de base de datos personalizadas.</p>
            <h3 class='text-xl font-bold mb-2'>Ejemplo: 'Diseñadores'</h3>
            <p class='mb-4'>Puedes crear un Metaobject llamado <em>Designer</em> con campos: Nombre, Biografía, e Imagen. Luego, en el producto, creas un Metafield de tipo 'Referencia a Metaobject' apuntando a un diseñador.</p>
            <p>Además, los Metaobjects pueden generar <strong>Webpages Dinámicas</strong>, permitiendo crear páginas SEO para cada diseñador automáticamente sin tocar código.</p>
        "
    ],
    "clientes-segmentacion" => [
        "title" => "Gestión y Segmentación de Clientes",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>El CRM de Shopify</h2>
            <p class='mb-4'>El panel de clientes almacena historial de compras, valor total de vida (LTV) y consentimientos de marketing.</p>
            <h3 class='text-xl font-bold mb-2'>Segmentos</h3>
            <p class='mb-4'>Utilizando el lenguaje de consulta de Shopify (ShopifyQL), puedes crear segmentos dinámicos que se actualizan en tiempo real:</p>
            <pre class='bg-gray-800 text-blue-300 p-4 rounded mb-4'><code>
customer_tags CONTAINS 'VIP' AND amount_spent > 1000
            </code></pre>
            <p>Estos segmentos son vitales para campañas de email marketing en Shopify Email o exportarlos a Klaviyo.</p>
        "
    ],
    "b2b-shopify" => [
        "title" => "B2B en Shopify",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Venta Mayorista (Exclusivo Plus)</h2>
            <p class='mb-4'>Shopify B2B transforma la plataforma de B2C a un modelo mixto, permitiendo vender al por mayor y al consumidor final desde una misma tienda.</p>
            <h3 class='text-xl font-bold mb-2'>Funcionalidades Core</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Empresas (Companies):</strong> Entidad que agrupa a múltiples compradores con roles asignados.</li>
                <li><strong>Catálogos de Precios:</strong> Listas de precios específicas o descuentos por porcentaje asignadas a cada empresa.</li>
                <li><strong>Condiciones de Pago:</strong> Soporte para 'Net 30', 'Net 60' o borradores de pedido que requieren aprobación previa.</li>
            </ul>
        "
    ],
    "canales-venta" => [
        "title" => "Canales de Venta",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Distribución Multicanal</h2>
            <p class='mb-4'>La tienda online es solo <em>un</em> canal de venta. Shopify actúa como el cerebro (PIM y OMS) que distribuye el catálogo a múltiples frentes.</p>
            <h3 class='text-xl font-bold mb-2'>Integraciones Clave</h3>
            <p class='mb-4'><strong>Google & YouTube:</strong> Sincroniza productos mediante API con el Google Merchant Center para Shopping Ads.</p>
            <p><strong>Shop App:</strong> La aplicación nativa de Shopify para compradores, con Shop Pay integrado que dispara la tasa de conversión hasta un 50% por su checkout acelerado en 1 clic.</p>
        "
    ],
    "shopify-pos" => [
        "title" => "Shopify POS (Punto de Venta)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Integración Físico-Digital</h2>
            <p class='mb-4'>La aplicación POS permite usar el mismo backend de Shopify en tiendas de ladrillo y mortero mediante iPads o hardware propio (POS Go).</p>
            <h3 class='text-xl font-bold mb-2'>Operaciones Unificadas</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Buy Online, Pick Up In Store (BOPIS):</strong> El cliente compra en la web y el pedido aparece instantáneamente en el iPad de la tienda física para ser preparado.</li>
                <li><strong>Ship to Home:</strong> Vender un producto en la tienda física que no tiene stock local, ordenando el envío desde el almacén central.</li>
            </ul>
        "
    ],
    "pedidos-fulfillment" => [
        "title" => "Gestión de Pedidos y Fulfillment",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>El Ciclo de Vida del Pedido</h2>
            <p class='mb-4'>Un pedido pasa por varios estados financieros y de preparación logística.</p>
            <h3 class='text-xl font-bold mb-2'>Estados Financieros</h3>
            <p class='mb-4'>Puede ser <em>Authorized</em> (tarjeta válida, fondos retenidos) o <em>Paid</em> (capturado). Capturar manualmente previene el fraude y ahorra comisiones por devoluciones si no hay stock.</p>
            <h3 class='text-xl font-bold mb-2'>Estados de Fulfillment</h3>
            <p>Cuando empaquetas el pedido e introduces el tracking number (ej. FedEx, Correos), el pedido pasa a <em>Fulfilled</em> y se dispara automáticamente el email de envío al cliente final.</p>
        "
    ],
    "devoluciones-reembolsos" => [
        "title" => "Devoluciones y Reembolsos",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Gestión de Inversas</h2>
            <p class='mb-4'>Shopify integra un sistema de RMAs (Return Merchandise Authorization) para agilizar las quejas.</p>
            <h3 class='text-xl font-bold mb-2'>El Flujo de Reembolso</h3>
            <ol class='list-decimal pl-5 mb-4'>
                <li>El cliente solicita la devolución (vía portal o atención al cliente).</li>
                <li>El comerciante aprueba y genera una etiqueta de envío de retorno (Return Label).</li>
                <li>Al recibir e inspeccionar el paquete, se procesa el reembolso (Restocking) que devuelve el producto al inventario y el dinero a la tarjeta original.</li>
            </ol>
            <p>Se pueden cobrar 'Restocking Fees' (tarifas de reposición) deduciéndolas del reembolso total.</p>
        "
    ],
    "shopify-markets" => [
        "title" => "Shopify Markets",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Expansión Internacional Nativa</h2>
            <p class='mb-4'>Antes, vender en múltiples países requería múltiples tiendas (ej. tienda .es y tienda .com). Markets unifica esto en una sola instancia.</p>
            <h3 class='text-xl font-bold mb-2'>Configuración por Mercado</h3>
            <ul class='list-disc pl-5 mb-4'>
                <li><strong>Monedas locales:</strong> Conversión de precios en tiempo real o precios fijos por región.</li>
                <li><strong>Dominios y Subcarpetas:</strong> Configuración de URLs específicas (ej. <code>tienda.com/es-mx/</code> para México).</li>
                <li><strong>Traducciones:</strong> Integración con la app Translate & Adapt para mantener el catálogo en varios idiomas sincronizado.</li>
            </ul>
        "
    ],
    "impuestos-taxes" => [
        "title" => "Configuración de Impuestos",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Complejidad Fiscal Automatizada</h2>
            <p class='mb-4'>El motor de impuestos determina cuánto cobrar basado en el origen y destino del pedido.</p>
            <h3 class='text-xl font-bold mb-2'>Conceptos Clave</h3>
            <p class='mb-4'><strong>Tax Overrides:</strong> Reglas especiales (ej. ropa infantil sin IVA en algunos países).</p>
            <p>En EE.UU., Shopify Tax calcula los impuestos a nivel estatal, de condado y municipal basándose en el <em>Nexus</em> (presencia física o económica de la empresa). Para Europa, gestiona las normativas VAT e IOSS automáticamente.</p>
        "
    ],
    "envios-zonas" => [
        "title" => "Perfiles y Zonas de Envío",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Lógica de Transporte</h2>
            <p class='mb-4'>Los gastos de envío son el motivo #1 de abandono de carritos. Su configuración requiere precisión.</p>
            <h3 class='text-xl font-bold mb-2'>Perfiles Generales vs Especiales</h3>
            <p class='mb-4'>Puedes cobrar 5€ por camisetas (Perfil General) pero 50€ por bicicletas (Perfil Frágil/Pesado). Los perfiles agrupan productos.</p>
            <h3 class='text-xl font-bold mb-2'>Reglas Condicionales</h3>
            <p>Puedes cobrar envío en base al precio total del carrito (ej. > 50€ = Envío Gratis) o al peso total (ej. > 5kg = 10€). Shopify evalúa la dirección del cliente, cruza con la Zona y aplica la tarifa correspondiente.</p>
        "
    ],
    "pasarelas-pago" => [
        "title" => "Shopify Payments y Pasarelas",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Flujos de Capital</h2>
            <p class='mb-4'><strong>Shopify Payments</strong> es la pasarela nativa (marca blanca de Stripe). Evita comisiones de transacción adicionales, integra Apple Pay, Google Pay y métodos locales (Bancontact, iDEAL, Klarna).</p>
            <h3 class='text-xl font-bold mb-2'>Pasarelas de Terceros</h3>
            <p>Si usas Redsys o PayPal como proveedor externo, Shopify cobra un % extra de penalización según el plan (2%, 1% o 0.5%). Integrar métodos de pago externos en el nuevo checkout requiere crear una <em>Payments App</em> bajo la nueva arquitectura web.</p>
        "
    ],
    "checkout-configuracion" => [
        "title" => "Configuración del Checkout",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>El Embudo Final</h2>
            <p class='mb-4'>El checkout de Shopify procesa miles de millones de dólares y está hiper-optimizado. Los planes estándar solo pueden modificar su aspecto visual (colores, logo, fuentes) desde el Theme Editor.</p>
            <h3 class='text-xl font-bold mb-2'>Campos de Formulario</h3>
            <p>Puedes configurar si requerir el teléfono, el nombre de empresa o habilitar la 'Propinas'. También es el lugar donde se configura el checkbox de suscripción al newsletter (marketing opt-in) vital para estrategias de retención.</p>
        "
    ],
    "checkout-extensibility" => [
        "title" => "Checkout Extensibility (Plus)",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Revolución para Developers</h2>
            <p class='mb-4'>Antiguamente, modificar el checkout requería inyectar código en el archivo oculto <code>checkout.liquid</code>. Esto era frágil y causaba fallos de seguridad.</p>
            <h3 class='text-xl font-bold mb-2'>App Blocks & Web Components</h3>
            <p>Exclusivo para Plus. Ahora los desarrolladores construyen <strong>Checkout UI Extensions</strong> en React. Estas extensiones se ejecutan en un entorno sandbox seguro (WebWorker). Permiten añadir banners, campos personalizados (ej. número de pasaporte) o upsells post-compra sin comprometer la PCI Compliance.</p>
        "
    ],
    "descuentos-cupones" => [
        "title" => "Descuentos y Códigos",
        "html" => "
            <h2 class='text-2xl font-bold mb-4 text-gray-800'>Estrategias Promocionales</h2>
            <p class='mb-4'>El motor de descuentos soporta: Porcentaje fijo, Monto fijo, Envío Gratis y Compra X Lleva Y (BOGO).</p>
            <h3 class='text-xl font-bold mb-2'>Combinabilidad</h3>
            <p>Recientemente, Shopify añadió la capacidad de <strong>combinar descuentos</strong>. Un cliente puede aplicar un código de 10% de descuento Y un código de envío gratis simultáneamente si el comerciante lo permite en la configuración de clase del descuento.</p>
        "
    ]
];
