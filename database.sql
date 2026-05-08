CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    xp INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS scores (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    xp_earned INT NOT NULL DEFAULT 0,
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS theory_modules (
    id SERIAL PRIMARY KEY,
    slug VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    content_html TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_0 VARCHAR(255) NOT NULL,
    option_1 VARCHAR(255) NOT NULL,
    option_2 VARCHAR(255) NOT NULL,
    option_3 TEXT NOT NULL,
    correct_answer_index INT NOT NULL,
    xp_reward INT DEFAULT 10,
    module_slug VARCHAR(50) DEFAULT 'general'
);

-- Insert Theory Modules
INSERT INTO theory_modules (slug, title, content_html) VALUES
('intro-ecommerce', 'Introducción al E-commerce y Shopify', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Ecosistema del E-commerce</h2>
            <p class=''mb-4''>El comercio electrónico moderno exige plataformas robustas. Shopify opera bajo un modelo <strong>SaaS (Software as a Service)</strong>. Esto significa que, a diferencia de Magento o WooCommerce (que requieren hosting, mantenimiento de servidores y actualizaciones de seguridad manuales), Shopify se encarga de toda la infraestructura.</p>
            <h3 class=''text-xl font-bold mb-2''>Ventajas Competitivas</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Escalabilidad:</strong> Soporta desde 1 hasta 10,000 transacciones por minuto sin caídas.</li>
                <li><strong>Seguridad Nivel 1 PCI DSS:</strong> Todo el procesamiento de tarjetas está asegurado de forma nativa.</li>
                <li><strong>CDN Global:</strong> Utiliza Fastly y Cloudflare para servir imágenes y código estático desde el servidor más cercano al cliente.</li>
            </ul>
        </div>'),
('arquitectura-shopify', 'Arquitectura de Shopify', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Infraestructura Subyacente</h2>
            <p class=''mb-4''>Shopify está construido principalmente sobre <strong>Ruby on Rails</strong> con bases de datos MySQL, aunque su arquitectura ha evolucionado hacia microservicios utilizando Go y Rust para componentes críticos de rendimiento.</p>
            <h3 class=''text-xl font-bold mb-2''>Componentes Clave</h3>
            <div class=''bg-gray-100 p-4 rounded mb-4''>
                <p><strong>El Monolito Core:</strong> Gestiona la lógica de negocio principal, el checkout y la interfaz de administración.</p>
                <p><strong>Storefront API:</strong> Capa GraphQL escrita en Go que sirve los datos a velocidades ultrarrápidas, utilizada por Hydrogen y aplicaciones móviles.</p>
            </div>
            <p>Comprender esta arquitectura es vital para no saturar la API con llamadas ineficientes.</p>
        </div>'),
('planes-precios', 'Planes y Precios de Shopify', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Estructura de Costes</h2>
            <p class=''mb-4''>Elegir el plan adecuado depende del volumen de ventas. Shopify ofrece:</p>
            <ul class=''list-disc pl-5 mb-4 space-y-2''>
                <li><strong>Basic:</strong> Ideal para empezar. Incluye 2 cuentas de empleado y comisiones de transacción más altas (aprox. 2.9% + 30¢ si no usas Shopify Payments).</li>
                <li><strong>Shopify:</strong> Añade reportes profesionales y reduce la comisión.</li>
                <li><strong>Advanced:</strong> Para negocios en crecimiento rápido. Mejores tasas y cálculo de envíos por terceros.</li>
                <li><strong>Shopify Plus:</strong> Nivel Enterprise (desde ,000/mes). Incluye Checkout Extensibility, B2B, Launchpad y cuentas ilimitadas.</li>
            </ul>
        </div>'),
('configuracion-inicial', 'Configuración Inicial de la Tienda', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Los Primeros Pasos</h2>
            <p class=''mb-4''>Antes de añadir productos, la configuración base debe estar impecable. Esto incluye:</p>
            <h3 class=''text-xl font-bold mb-2 text-indigo-700''>Ajustes Generales</h3>
            <p class=''mb-4''>En <em>Configuración > Información de la tienda</em> debes definir el formato de moneda (con o sin decimales) y los prefijos de pedido (ej. #ESP-1001) para integrarlos correctamente con el ERP.</p>
            <h3 class=''text-xl font-bold mb-2 text-indigo-700''>Políticas Legales</h3>
            <p>Shopify permite generar plantillas automáticas para Política de Privacidad, Términos del Servicio y Política de Devoluciones. Estas páginas deben enlazarse obligatoriamente en el footer del tema por motivos legales.</p>
        </div>'),
('gestion-dominios', 'Gestión de Dominios', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Configuración DNS y SSL</h2>
            <p class=''mb-4''>Tu tienda incluye un dominio <em>.myshopify.com</em> gratuito que no debe indexarse en buscadores. Para conectar un dominio personalizado:</p>
            <pre class=''bg-gray-800 text-green-400 p-4 rounded mb-4''><code>
Registro A   -> Apunta a la IP de Shopify (23.227.38.65)
Registro CNAME -> Apunta a shops.myshopify.com (para el subdominio www)
            </code></pre>
            <p>Shopify genera automáticamente <strong>certificados SSL</strong> mediante Let''s Encrypt. Como desarrollador, asegúrate de forzar la redirección del tráfico HTTP a HTTPS marcando el dominio como ''Principal'' en el admin.</p>
        </div>'),
('productos-variantes', 'Productos y Variantes', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Estructura del Catálogo</h2>
            <p class=''mb-4''>Cada producto en Shopify puede tener hasta <strong>3 opciones</strong> (ej. Tamaño, Color, Material) y un límite estricto de <strong>100 variantes</strong>.</p>
            <h3 class=''text-xl font-bold mb-2''>Componentes de una Variante</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>SKU:</strong> Obligatorio para control de inventario.</li>
                <li><strong>Barcode (GTIN/UPC):</strong> Necesario para integraciones con Google Shopping y Amazon.</li>
                <li><strong>Inventory Item:</strong> Objeto que enlaza la variante con ubicaciones físicas.</li>
            </ul>
            <p>Si un producto requiere más de 100 variantes, debes usar apps de terceros (Product Options) o separar el producto usando Metaobjects.</p>
        </div>'),
('colecciones-manuales', 'Colecciones Manuales', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Curación de Productos</h2>
            <p class=''mb-4''>Las colecciones manuales permiten agrupar productos seleccionándolos uno por uno. Son ideales para:</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li>Campañas estacionales (ej. ''Rebajas de Verano'').</li>
                <li>Lookbooks o colecciones cápsula muy específicas.</li>
            </ul>
            <h3 class=''text-xl font-bold mb-2''>Ordenación Personalizada</h3>
            <p>A diferencia de las automatizadas, las colecciones manuales permiten el arrastrar y soltar (drag & drop) para elegir exactamente en qué orden aparecen los productos en el frontend, lo cual es crucial para estrategias de merchandising visual.</p>
        </div>'),
('colecciones-automatizadas', 'Colecciones Automatizadas', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Escalabilidad del Catálogo</h2>
            <p class=''mb-4''>Las colecciones automatizadas añaden productos basándose en reglas condicionales, eliminando el trabajo manual en catálogos grandes.</p>
            <h3 class=''text-xl font-bold mb-2''>Reglas Comunes</h3>
            <pre class=''bg-gray-800 text-blue-300 p-4 rounded mb-4''><code>
1. Etiqueta del producto ES IGUAL A ''novedad''
2. Precio del producto ES MAYOR QUE 50
3. Inventario disponible ES MAYOR QUE 0
            </code></pre>
            <p><strong>Nota técnica:</strong> Las condiciones pueden configurarse para cumplir <em>todas</em> (AND) o <em>cualquier</em> condición (OR). Es la base del SEO estructurado en grandes e-commerce.</p>
        </div>'),
('inventario-ubicaciones', 'Inventario y Ubicaciones', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Gestión Omnicanal</h2>
            <p class=''mb-4''>Shopify permite rastrear inventario en múltiples <strong>Locations</strong> (tiendas físicas, almacenes o centros logísticos externos).</p>
            <h3 class=''text-xl font-bold mb-2''>Prioridad de Fulfillment</h3>
            <p class=''mb-4''>Cuando entra un pedido, el algoritmo de Shopify decide desde qué almacén descontar el stock basándose en las reglas de enrutamiento (Order Routing).</p>
            <p>Como desarrollador, cuando consultas la disponibilidad en Liquid, <code>product.available</code> verifica todas las ubicaciones. Si necesitas verificar el stock en una tienda específica para Click & Collect, usarás la Storefront API.</p>
        </div>'),
('etiquetas-tags', 'Sistema de Etiquetas (Tags)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Metadatos Flexibles</h2>
            <p class=''mb-4''>Los tags son cadenas de texto simples que se pueden añadir a Productos, Pedidos, Clientes y Artículos de Blog.</p>
            <h3 class=''text-xl font-bold mb-2''>Casos de Uso Principales</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Productos:</strong> Filtros en la barra lateral del catálogo (ej. tag ''material-cuero'').</li>
                <li><strong>Clientes:</strong> Asignar niveles VIP (ej. tag ''mayorista'') para alterar precios vía Liquid.</li>
                <li><strong>Pedidos:</strong> Marcar pedidos fraudulentos o que requieren revisión manual.</li>
            </ul>
            <p>Tienen un límite estricto de 250 tags por producto y no admiten estructuras clave-valor (para eso usamos Metafields).</p>
        </div>'),
('metafields-intro', 'Introducción a los Metafields', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Extensión de Datos Nativos</h2>
            <p class=''mb-4''>Los metafields son la respuesta de Shopify para almacenar información estructurada adicional que no viene por defecto en la plataforma.</p>
            <h3 class=''text-xl font-bold mb-2''>Estructura de un Metafield</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Namespace:</strong> Agrupación lógica (ej. <code>instrucciones</code>).</li>
                <li><strong>Key:</strong> Identificador (ej. <code>lavado</code>).</li>
                <li><strong>Type:</strong> Tipo de dato (String, Integer, Color, JSON).</li>
            </ul>
            <pre class=''bg-gray-800 text-pink-400 p-4 rounded mb-4''><code>
{{ product.metafields.instrucciones.lavado.value }}
            </code></pre>
            <p>Se pueden conectar directamente con el Theme Editor usando Fuentes Dinámicas (Dynamic Sources) en OS 2.0.</p>
        </div>'),
('metaobjects-intro', 'Metaobjects: Tablas Personalizadas', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Base de Datos Relacional en Shopify</h2>
            <p class=''mb-4''>A diferencia de los Metafields (que se unen a un producto específico), los <strong>Metaobjects</strong> son entidades independientes. Actúan como tablas de base de datos personalizadas.</p>
            <h3 class=''text-xl font-bold mb-2''>Ejemplo: ''Diseñadores''</h3>
            <p class=''mb-4''>Puedes crear un Metaobject llamado <em>Designer</em> con campos: Nombre, Biografía, e Imagen. Luego, en el producto, creas un Metafield de tipo ''Referencia a Metaobject'' apuntando a un diseñador.</p>
            <p>Además, los Metaobjects pueden generar <strong>Webpages Dinámicas</strong>, permitiendo crear páginas SEO para cada diseñador automáticamente sin tocar código.</p>
        </div>'),
('clientes-segmentacion', 'Gestión y Segmentación de Clientes', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El CRM de Shopify</h2>
            <p class=''mb-4''>El panel de clientes almacena historial de compras, valor total de vida (LTV) y consentimientos de marketing.</p>
            <h3 class=''text-xl font-bold mb-2''>Segmentos</h3>
            <p class=''mb-4''>Utilizando el lenguaje de consulta de Shopify (ShopifyQL), puedes crear segmentos dinámicos que se actualizan en tiempo real:</p>
            <pre class=''bg-gray-800 text-blue-300 p-4 rounded mb-4''><code>
customer_tags CONTAINS ''VIP'' AND amount_spent > 1000
            </code></pre>
            <p>Estos segmentos son vitales para campañas de email marketing en Shopify Email o exportarlos a Klaviyo.</p>
        </div>'),
('b2b-shopify', 'B2B en Shopify', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Venta Mayorista (Exclusivo Plus)</h2>
            <p class=''mb-4''>Shopify B2B transforma la plataforma de B2C a un modelo mixto, permitiendo vender al por mayor y al consumidor final desde una misma tienda.</p>
            <h3 class=''text-xl font-bold mb-2''>Funcionalidades Core</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Empresas (Companies):</strong> Entidad que agrupa a múltiples compradores con roles asignados.</li>
                <li><strong>Catálogos de Precios:</strong> Listas de precios específicas o descuentos por porcentaje asignadas a cada empresa.</li>
                <li><strong>Condiciones de Pago:</strong> Soporte para ''Net 30'', ''Net 60'' o borradores de pedido que requieren aprobación previa.</li>
            </ul>
        </div>'),
('canales-venta', 'Canales de Venta', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Distribución Multicanal</h2>
            <p class=''mb-4''>La tienda online es solo <em>un</em> canal de venta. Shopify actúa como el cerebro (PIM y OMS) que distribuye el catálogo a múltiples frentes.</p>
            <h3 class=''text-xl font-bold mb-2''>Integraciones Clave</h3>
            <p class=''mb-4''><strong>Google & YouTube:</strong> Sincroniza productos mediante API con el Google Merchant Center para Shopping Ads.</p>
            <p><strong>Shop App:</strong> La aplicación nativa de Shopify para compradores, con Shop Pay integrado que dispara la tasa de conversión hasta un 50% por su checkout acelerado en 1 clic.</p>
        </div>'),
('shopify-pos', 'Shopify POS (Punto de Venta)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Integración Físico-Digital</h2>
            <p class=''mb-4''>La aplicación POS permite usar el mismo backend de Shopify en tiendas de ladrillo y mortero mediante iPads o hardware propio (POS Go).</p>
            <h3 class=''text-xl font-bold mb-2''>Operaciones Unificadas</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Buy Online, Pick Up In Store (BOPIS):</strong> El cliente compra en la web y el pedido aparece instantáneamente en el iPad de la tienda física para ser preparado.</li>
                <li><strong>Ship to Home:</strong> Vender un producto en la tienda física que no tiene stock local, ordenando el envío desde el almacén central.</li>
            </ul>
        </div>'),
('pedidos-fulfillment', 'Gestión de Pedidos y Fulfillment', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Ciclo de Vida del Pedido</h2>
            <p class=''mb-4''>Un pedido pasa por varios estados financieros y de preparación logística.</p>
            <h3 class=''text-xl font-bold mb-2''>Estados Financieros</h3>
            <p class=''mb-4''>Puede ser <em>Authorized</em> (tarjeta válida, fondos retenidos) o <em>Paid</em> (capturado). Capturar manualmente previene el fraude y ahorra comisiones por devoluciones si no hay stock.</p>
            <h3 class=''text-xl font-bold mb-2''>Estados de Fulfillment</h3>
            <p>Cuando empaquetas el pedido e introduces el tracking number (ej. FedEx, Correos), el pedido pasa a <em>Fulfilled</em> y se dispara automáticamente el email de envío al cliente final.</p>
        </div>'),
('devoluciones-reembolsos', 'Devoluciones y Reembolsos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Gestión de Inversas</h2>
            <p class=''mb-4''>Shopify integra un sistema de RMAs (Return Merchandise Authorization) para agilizar las quejas.</p>
            <h3 class=''text-xl font-bold mb-2''>El Flujo de Reembolso</h3>
            <ol class=''list-decimal pl-5 mb-4''>
                <li>El cliente solicita la devolución (vía portal o atención al cliente).</li>
                <li>El comerciante aprueba y genera una etiqueta de envío de retorno (Return Label).</li>
                <li>Al recibir e inspeccionar el paquete, se procesa el reembolso (Restocking) que devuelve el producto al inventario y el dinero a la tarjeta original.</li>
            </ol>
            <p>Se pueden cobrar ''Restocking Fees'' (tarifas de reposición) deduciéndolas del reembolso total.</p>
        </div>'),
('shopify-markets', 'Shopify Markets', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Expansión Internacional Nativa</h2>
            <p class=''mb-4''>Antes, vender en múltiples países requería múltiples tiendas (ej. tienda .es y tienda .com). Markets unifica esto en una sola instancia.</p>
            <h3 class=''text-xl font-bold mb-2''>Configuración por Mercado</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Monedas locales:</strong> Conversión de precios en tiempo real o precios fijos por región.</li>
                <li><strong>Dominios y Subcarpetas:</strong> Configuración de URLs específicas (ej. <code>tienda.com/es-mx/</code> para México).</li>
                <li><strong>Traducciones:</strong> Integración con la app Translate & Adapt para mantener el catálogo en varios idiomas sincronizado.</li>
            </ul>
        </div>'),
('impuestos-taxes', 'Configuración de Impuestos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Complejidad Fiscal Automatizada</h2>
            <p class=''mb-4''>El motor de impuestos determina cuánto cobrar basado en el origen y destino del pedido.</p>
            <h3 class=''text-xl font-bold mb-2''>Conceptos Clave</h3>
            <p class=''mb-4''><strong>Tax Overrides:</strong> Reglas especiales (ej. ropa infantil sin IVA en algunos países).</p>
            <p>En EE.UU., Shopify Tax calcula los impuestos a nivel estatal, de condado y municipal basándose en el <em>Nexus</em> (presencia física o económica de la empresa). Para Europa, gestiona las normativas VAT e IOSS automáticamente.</p>
        </div>'),
('envios-zonas', 'Perfiles y Zonas de Envío', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Lógica de Transporte</h2>
            <p class=''mb-4''>Los gastos de envío son el motivo #1 de abandono de carritos. Su configuración requiere precisión.</p>
            <h3 class=''text-xl font-bold mb-2''>Perfiles Generales vs Especiales</h3>
            <p class=''mb-4''>Puedes cobrar 5€ por camisetas (Perfil General) pero 50€ por bicicletas (Perfil Frágil/Pesado). Los perfiles agrupan productos.</p>
            <h3 class=''text-xl font-bold mb-2''>Reglas Condicionales</h3>
            <p>Puedes cobrar envío en base al precio total del carrito (ej. > 50€ = Envío Gratis) o al peso total (ej. > 5kg = 10€). Shopify evalúa la dirección del cliente, cruza con la Zona y aplica la tarifa correspondiente.</p>
        </div>'),
('pasarelas-pago', 'Shopify Payments y Pasarelas', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Flujos de Capital</h2>
            <p class=''mb-4''><strong>Shopify Payments</strong> es la pasarela nativa (marca blanca de Stripe). Evita comisiones de transacción adicionales, integra Apple Pay, Google Pay y métodos locales (Bancontact, iDEAL, Klarna).</p>
            <h3 class=''text-xl font-bold mb-2''>Pasarelas de Terceros</h3>
            <p>Si usas Redsys o PayPal como proveedor externo, Shopify cobra un % extra de penalización según el plan (2%, 1% o 0.5%). Integrar métodos de pago externos en el nuevo checkout requiere crear una <em>Payments App</em> bajo la nueva arquitectura web.</p>
        </div>'),
('checkout-configuracion', 'Configuración del Checkout', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Embudo Final</h2>
            <p class=''mb-4''>El checkout de Shopify procesa miles de millones de dólares y está hiper-optimizado. Los planes estándar solo pueden modificar su aspecto visual (colores, logo, fuentes) desde el Theme Editor.</p>
            <h3 class=''text-xl font-bold mb-2''>Campos de Formulario</h3>
            <p>Puedes configurar si requerir el teléfono, el nombre de empresa o habilitar la ''Propinas''. También es el lugar donde se configura el checkbox de suscripción al newsletter (marketing opt-in) vital para estrategias de retención.</p>
        </div>'),
('checkout-extensibility', 'Checkout Extensibility (Plus)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Revolución para Developers</h2>
            <p class=''mb-4''>Antiguamente, modificar el checkout requería inyectar código en el archivo oculto <code>checkout.liquid</code>. Esto era frágil y causaba fallos de seguridad.</p>
            <h3 class=''text-xl font-bold mb-2''>App Blocks & Web Components</h3>
            <p>Exclusivo para Plus. Ahora los desarrolladores construyen <strong>Checkout UI Extensions</strong> en React. Estas extensiones se ejecutan en un entorno sandbox seguro (WebWorker). Permiten añadir banners, campos personalizados (ej. número de pasaporte) o upsells post-compra sin comprometer la PCI Compliance.</p>
        </div>'),
('descuentos-cupones', 'Descuentos y Códigos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Estrategias Promocionales</h2>
            <p class=''mb-4''>El motor de descuentos soporta: Porcentaje fijo, Monto fijo, Envío Gratis y Compra X Lleva Y (BOGO).</p>
            <h3 class=''text-xl font-bold mb-2''>Combinabilidad</h3>
            <p>Recientemente, Shopify añadió la capacidad de <strong>combinar descuentos</strong>. Un cliente puede aplicar un código de 10% de descuento Y un código de envío gratis simultáneamente si el comerciante lo permite en la configuración de clase del descuento.</p>
        </div>'),
('descuentos-automaticos', 'Descuentos Automáticos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Conversión sin Fricción</h2>
            <p class=''mb-4''>A diferencia de los cupones que el usuario debe buscar y escribir en el checkout (lo que causa salidas hacia Google buscando ''cupones de descuento''), los descuentos automáticos se aplican solos en el carrito cuando se cumplen condiciones lógicas.</p>
            <h3 class=''text-xl font-bold mb-2''>Ejemplos de Aplicación</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Volumen:</strong> 20% OFF en todos los accesorios al comprar un ordenador.</li>
                <li><strong>Flash Sales:</strong> Todos los productos de la colección ''Invierno'' rebajados sin usar el campo de ''precio comparado'' producto a producto.</li>
            </ul>
        </div>'),
('tarjetas-regalo', 'Tarjetas de Regalo (Gift Cards)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Micro-economía del E-commerce</h2>
            <p class=''mb-4''>Las Gift Cards en Shopify se comportan como un producto pero no generan un revenue real hasta que son canjeadas (principio contable de pasivo diferido). Se envían por email con un código único y pueden ser agregadas a Apple Wallet.</p>
            <p><strong>Casos de desarrollo:</strong> Si usas la API de Admin, puedes emitir Gift Cards masivamente como compensación a clientes en lugar de emitir un reembolso de dinero a la tarjeta (mejorando el Cash Flow).</p>
        </div>'),
('marketing-basico', 'Marketing y Retención', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Ciclo de Vida del Cliente</h2>
            <p class=''mb-4''>El coste de adquisición (CAC) es alto. La rentabilidad viene de la retención. Shopify incluye herramientas nativas como Shopify Email (gratis hasta 10,000 correos al mes) para enviar newsletters directamente desde el panel.</p>
            <h3 class=''text-xl font-bold mb-2''>Automatizaciones Base</h3>
            <p>El flujo más crítico es el de <strong>Carrito Abandonado</strong>. Si un usuario introduce su email en el checkout pero no paga, Shopify retiene esa sesión y puede enviar un correo a las 10 horas ofreciendo un 5% de descuento para cerrar la venta.</p>
        </div>'),
('seo-basico', 'SEO Técnico en Shopify', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Visibilidad Orgánica</h2>
            <p class=''mb-4''>Shopify auto-genera y mantiene los archivos <code>sitemap.xml</code> y <code>robots.txt</code>. Permite editar libremente el Title, Meta Description y URL Handle de cada recurso.</p>
            <h3 class=''text-xl font-bold mb-2''>Consideraciones Estructurales</h3>
            <p>Las URLs en Shopify tienen un formato rígido. Un producto siempre estará en <code>/products/nombre</code> y una colección en <code>/collections/nombre</code>. Un error común es enlazar a un producto *dentro* de una colección (<code>/collections/zapatos/products/zapato1</code>) lo que genera contenido duplicado a ojos de Google. Como desarrollador, debes asegurarte que el tema enlaza usando el filtro de Liquid <code>within: collection</code> con cuidado o mejor, forzar URLs canónicas.</p>
        </div>'),
('redirecciones-301', 'Redirecciones 301', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Migraciones Sin Dolor</h2>
            <p class=''mb-4''>Cuando un cliente migra de Prestashop a Shopify, sus URLs antiguas dejarán de funcionar (Error 404), perdiendo todo su posicionamiento en Google.</p>
            <p>En <em>Navegación > Redirecciones de URL</em>, puedes importar un CSV que le diga a Shopify: ''Si alguien entra a <code>/catalogo.php?id=12</code>, redirígelo permanentemente (Código 301) a <code>/products/zapatilla-nike</code>''. Esto traspasa la autoridad del enlace (Link Juice).</p>
        </div>'),
('analitica-reportes', 'Analítica y Reportes', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Business Intelligence</h2>
            <p class=''mb-4''>Shopify centraliza los datos (sesiones, ventas por UTMs de campañas, retornos, CAC). La métrica reina es la <strong>Tasa de Conversión (CR)</strong>, que mide el % de sesiones que acaban en compra (promedio sector 1.5% - 2.5%).</p>
            <h3 class=''text-xl font-bold mb-2''>Integraciones</h3>
            <p>Aunque el panel de Shopify es robusto, siempre debe complementarse con Google Analytics 4 (mediante la app nativa de Google Channel) para analizar mapas de calor, flujos de navegación complejos y comportamiento de abandono de embudo detallado.</p>
        </div>'),
('liquid-sintaxis', 'Liquid: Sintaxis Básica', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Lenguaje del Frontend</h2>
            <p class=''mb-4''>Liquid es un motor de plantillas de código abierto creado por Shopify escrito originalmente en Ruby. No es PHP, se ejecuta en el servidor y devuelve HTML puro.</p>
            <h3 class=''text-xl font-bold mb-2''>Bloques Principales</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Output (Doble llave):</strong> <code>{{ product.title }}</code> -> Imprime el título del producto.</li>
                <li><strong>Tags (Llave y porcentaje):</strong> <code>{% if user %} Hola {% endif %}</code> -> Ejecuta lógica (condicionales, bucles).</li>
                <li><strong>Filtros (Barra vertical):</strong> <code>{{ ''hola'' | upcase }}</code> -> Transforma el output a ''HOLA''.</li>
            </ul>
        </div>'),
('liquid-filtros', 'Liquid: Filtros Avanzados', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Manipulación de Datos al Vuelo</h2>
            <p class=''mb-4''>Los filtros permiten procesar la información directamente en la plantilla sin requerir lógica en el backend.</p>
            <h3 class=''text-xl font-bold mb-2''>Filtros Clave</h3>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>Dinero:</strong> <code>{{ product.price | money_with_currency }}</code> (Formatea el entero a ej. ''29,99 € EUR'').</li>
                <li><strong>Imágenes:</strong> <code>{{ product.featured_image | image_url: width: 400 }}</code> (Pide al CDN de Shopify que genere y sirva una versión optimizada de 400px en formato WebP dinámicamente).</li>
                <li><strong>Arrays:</strong> <code>map</code>, <code>join</code>, <code>sort</code>, <code>where</code> para extraer y manipular listas complejas de objetos.</li>
            </ul>
        </div>'),
('liquid-bucles', 'Liquid: Iteración', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Manejo de Listas y Paginate</h2>
            <p class=''mb-4''>Para mostrar productos, iteramos sobre colecciones usando bucles <code>for</code>.</p>
            <pre class=''bg-gray-800 text-green-400 p-4 rounded mb-4''><code>
{% paginate collection.products by 12 %}
  {% for product in collection.products %}
    &lt;!-- Render Product Card --&gt;
  {% endfor %}
  {{ paginate | default_pagination }}
{% endpaginate %}
            </code></pre>
            <p><strong>Límite crítico:</strong> Shopify restringe las colecciones a un máximo de 50 elementos devueltos por llamada. Si no envuelves el bucle en un bloque <code>paginate</code>, la página se romperá o solo mostrará los primeros 50.</p>
        </div>'),
('os2-arquitectura', 'Online Store 2.0 (OS 2.0)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>La Nueva Era Temática</h2>
            <p class=''mb-4''>Antes de 2021, solo la página de inicio (Homepage) podía tener bloques arrastrables (Secciones). OS 2.0 cambió la arquitectura: ahora las plantillas no son archivos <code>.liquid</code>, son archivos <code>.json</code> que mapean qué secciones van en qué orden.</p>
            <p>Esto permite a los comerciantes construir páginas completas (Acerca de, FAQ, Landing Pages) usando bloques visuales sin necesitar a un desarrollador para cada pequeño cambio estructural.</p>
        </div>'),
('os2-secciones', 'Desarrollo de Secciones (Sections)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Componentes Reutilizables</h2>
            <p class=''mb-4''>Una sección es un archivo Liquid autónomo. El ''secreto'' es la etiqueta <code>{% schema %}</code>, que define la interfaz en el Theme Editor.</p>
            <pre class=''bg-gray-800 text-yellow-300 p-4 rounded mb-4 text-sm''><code>
{% schema %}
{
  "name": "Hero Banner",
  "settings": [
    { "type": "text", "id": "title", "label": "Título principal" },
    { "type": "image_picker", "id": "bg_image", "label": "Fondo" }
  ]
}
{% endschema %}
            </code></pre>
            <p>Lo que definas en este JSON, aparecerá como controles visuales (cajas de texto, selectores de color) para el administrador de la tienda, y podrás leer esos valores en el HTML usando <code>{{ section.settings.title }}</code>.</p>
        </div>'),
('os2-app-blocks', 'App Blocks y Theme App Extensions', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Ecosistema Limpio</h2>
            <p class=''mb-4''>El mayor problema histórico de Shopify era la desinstalación de Apps. Las apps inyectaban código sucio en los archivos del tema, y al desinstalarse, dejaban ''basura'' que ralentizaba la web.</p>
            <p><strong>Theme App Extensions</strong> resuelven esto. Ahora las apps proveen ''Bloques'' que el usuario arrastra visualmente en el editor. El código de la app vive aislado. Si se desinstala la app, el bloque desaparece automáticamente sin dejar rastro en el código fuente de la tienda.</p>
        </div>'),
('shopify-cli', 'Shopify CLI y Entorno Local', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Herramientas de Desarrollador</h2>
            <p class=''mb-4''>Shopify CLI es un paquete Node.js (se ejecuta en tu terminal con <code>shopify theme dev</code>) que permite:</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li>Crear un túnel seguro (Cloudflare) para ver tu código local ejecutándose contra los datos reales (productos, colecciones) de la base de datos de producción de la tienda.</li>
                <li>Hot-reloading instantáneo de CSS y Liquid en tu navegador mientras programas.</li>
                <li>Desplegar cambios directamente (<code>shopify theme push</code>) sin usar el antiguo y lento Theme Kit.</li>
            </ul>
        </div>'),
('github-integration', 'Integración con GitHub', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>CI/CD Nativo en Shopify</h2>
            <p class=''mb-4''>Puedes conectar un repositorio de GitHub al panel de administración de Shopify. Cada rama (branch) se convertirá en un tema previsualizable oculto en la tienda.</p>
            <p>Cuando un desarrollador hace <code>git push origin main</code>, Shopify detecta el webhook de GitHub y actualiza automáticamente el código del tema principal en milisegundos, permitiendo un flujo de trabajo profesional con Pull Requests y Code Review antes de ir a producción.</p>
        </div>'),
('hydrogen-oxygen', 'Hydrogen y Oxygen (Headless)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Futuro Desacoplado</h2>
            <p class=''mb-4''><strong>Hydrogen</strong> es el stack Headless de Shopify. Basado en <em>Remix</em> (framework de React), permite crear tiendas súper rápidas e interactivas que no usan Liquid en absoluto, leyendo datos directamente de la Storefront API vía GraphQL.</p>
            <p><strong>Oxygen</strong> es la plataforma de hosting global (basada en Workers) construida por Shopify para alojar estas aplicaciones Hydrogen gratuitamente, resolviendo el histórico problema de tener que pagar a Vercel o Netlify para alojar frontends Headless de tiendas Shopify.</p>
        </div>'),
('storefront-api', 'Storefront API (GraphQL)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>La API Pública</h2>
            <p class=''mb-4''>Es un endpoint de GraphQL diseñado para no requerir autenticación de servidor a servidor. Usa un token público.</p>
            <h3 class=''text-xl font-bold mb-2''>¿Para qué se usa?</h3>
            <p>Para construir experiencias de compra fuera del entorno tradicional web: aplicaciones móviles nativas (iOS/Android), integraciones en videojuegos (ej. comprar merchandising sin salir de Fortnite), o para construir un frontend a medida con React, Vue o Svelte.</p>
        </div>'),
('admin-api-rest', 'Admin API (Rest y GraphQL)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>El Control Total</h2>
            <p class=''mb-4''>Esta API es privada y requiere autenticación segura (Tokens o OAuth). Permite leer, crear y borrar cualquier dato del backend de la tienda (inventario, pedidos, reportes, reembolsos).</p>
            <h3 class=''text-xl font-bold mb-2''>REST vs GraphQL</h3>
            <p>Shopify mantiene su API REST por retrocompatibilidad, pero <strong>GraphQL es obligatorio</strong> para acceder a nuevas funcionalidades (como bulk operations o Metaobjects). GraphQL soluciona el problema de tener que hacer 10 peticiones HTTP (REST) para obtener datos anidados (Over-fetching).</p>
        </div>'),
('webhooks-eventos', 'Webhooks y Eventos', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Arquitectura Orientada a Eventos</h2>
            <p class=''mb-4''>Un Webhook permite que tu servidor reciba una notificación (payload JSON) en tiempo real en lugar de tener que consultar la API (polling) constantemente.</p>
            <p><strong>Ejemplo:</strong> Registras el evento <code>orders/create</code>. Cuando un cliente compra, Shopify dispara un POST a tu URL (ej. <code>mi-erp.com/shopify-webhook</code>). Tu servidor lo procesa de inmediato. Es crítico validar el header <code>X-Shopify-Hmac-Sha256</code> para asegurar que el mensaje es realmente de Shopify y no de un hacker.</p>
        </div>'),
('custom-apps', 'Custom Apps', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Desarrollo Privado</h2>
            <p class=''mb-4''>Las Custom Apps se instalan directamente en una tienda específica a través del panel de administración (Settings > Apps and Sales Channels). No requieren revisión pública por parte de Shopify.</p>
            <p>Se usan principalmente para construir conectores B2B a medida, integraciones con sistemas contables locales, o dashboards internos especializados que consumen la Admin API mediante un ''Access Token'' generado permanentemente.</p>
        </div>'),
('public-apps', 'Public Apps y App Store', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Desarrollo SaaS B2B</h2>
            <p class=''mb-4''>Crear una app para vender a miles de comerciantes requiere un nivel técnico mayor.</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>OAuth 2.0:</strong> La instalación requiere redirigir al comerciante, pedir permisos (ej. leer productos) e intercambiar un código por un token de sesión.</li>
                <li><strong>Billing API:</strong> Tienes que integrarte con el motor de cobros de Shopify (cargos recurrentes, freemium) para que Shopify le cobre al comerciante en su factura mensual y luego te transfiera tu parte.</li>
                <li><strong>Proceso de Revisión:</strong> Shopify probará la app exhaustivamente antes de admitirla en la tienda de aplicaciones.</li>
            </ul>
        </div>'),
('shopify-flow', 'Shopify Flow (Automatizaciones)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>No-Code Logic</h2>
            <p class=''mb-4''>Shopify Flow es un constructor visual de lógicas empresariales. Sigue la estructura: <strong>Trigger</strong> (Disparador), <strong>Condition</strong> (Condición), <strong>Action</strong> (Acción).</p>
            <p><strong>Ejemplos Reales:</strong></p>
            <ul class=''list-disc pl-5 mb-4''>
                <li>Si el stock de un producto baja de 10 unidades -> Enviar Slack a Compras y pausar anuncios en Google Ads.</li>
                <li>Si un pedido es marcado como ''Alto riesgo de Fraude'' -> Cancelar pedido, hacer reembolso automático, y etiquetar al cliente como bloqueado.</li>
            </ul>
            <p>Los desarrolladores pueden construir conectores (App Actions) para que Flow pueda integrarse con sus propias aplicaciones.</p>
        </div>'),
('shopify-functions', 'Shopify Functions (WASM/Rust)', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Extensibilidad del Backend</h2>
            <p class=''mb-4''>Las Functions reemplazan a los antiguos <em>Shopify Scripts</em>. Permiten ejecutar código personalizado a nivel de servidor <strong>dentro</strong> de la infraestructura hiper-rápida de Shopify.</p>
            <p>Los programadores escriben la lógica de descuentos complejos o reglas logísticas en <strong>Rust, C++ o Javascript (Javy)</strong>, lo compilan a WebAssembly (WASM) y lo suben. Estas funciones se ejecutan en milisegundos durante el checkout sin introducir latencia, solucionando necesidades complejas de descuentos (ej. "3x2 si el producto es de esta marca y el usuario es VIP tier 2").</p>
        </div>'),
('pixels-tracking', 'Web Pixel Manager y Tracking', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Seguridad en la Analítica</h2>
            <p class=''mb-4''>Históricamente, los píxeles de Facebook, Google y TikTok se inyectaban en el <code>theme.liquid</code>, accediendo indiscriminadamente a todo el DOM y comprometiendo el rendimiento y la privacidad.</p>
            <p>Shopify introdujo una API unificada (Customer Events). Los píxeles corren en un <strong>entorno Web Worker aislado (Sandbox)</strong>. Ya no pueden acceder a la página web real, sino que se suscriben a eventos emitidos por Shopify de forma estandarizada (<code>checkout_completed</code>, <code>product_viewed</code>), aumentando la velocidad de carga de la web y el cumplimiento de leyes como la RGPD.</p>
        </div>'),
('optimizacion-rendimiento', 'Optimización de Rendimiento', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Core Web Vitals</h2>
            <p class=''mb-4''>La velocidad impacta directamente al SEO y la conversión. Las responsabilidades de un desarrollador Shopify experto incluyen:</p>
            <ul class=''list-disc pl-5 mb-4''>
                <li><strong>LCP (Largest Contentful Paint):</strong> Precargar (<code>preload</code>) la imagen principal del producto y desactivar el ''lazy loading'' en el LCP.</li>
                <li><strong>CLS (Cumulative Layout Shift):</strong> Definir siempre <code>width</code> y <code>height</code> de las imágenes (usando el atributo <code>aspect-ratio</code> de CSS) para reservar el espacio antes de que carguen.</li>
                <li><strong>Limpieza de Apps:</strong> Evaluar impactos y desactivar scripts sobrantes.</li>
            </ul>
        </div>'),
('seguridad-fraude', 'Seguridad y Análisis de Fraude', '<div class=''text-gray-700 leading-relaxed max-w-4xl''>
            <h2 class=''text-2xl font-bold mb-4 text-gray-800''>Protección contra Chargebacks</h2>
            <p class=''mb-4''>Los fraudes en tarjetas de crédito son el mayor agujero económico del comercio B2C. Shopify integra un motor de análisis de fraude automático usando Machine Learning.</p>
            <p>Verifica disparidades como que la IP sea de Rusia, pero la dirección de entrega en España, o que el CVV esté ausente pero la transacción haya pasado (común en robos masivos de tarjetas). Un comerciante o un script de automatización pueden decidir rechazar estos pagos antes de enviarlos, previniendo así un ''Chargeback'' del banco que conlleva tarifas punitivas de 15$ a 30$.</p>
        </div>');


-- Insert Questions
INSERT INTO questions (question_text, option_0, option_1, option_2, option_3, correct_answer_index, xp_reward, module_slug) VALUES
('¿Qué lenguaje de plantillas utiliza Shopify para sus temas?', 'PHP', 'Liquid', 'Jinja', 'Blade', 1, 10, 'liquid-sintaxis'),
('¿Qué símbolo se usa en Liquid para mostrar la salida de una variable (Output)?', '{% %}', '[[ ]]', '{{ }}', '<?php ?>', 2, 10, 'liquid-sintaxis'),
('¿Qué hace el carácter de tubería "|" en Liquid?', 'Cierra un bloque if', 'Aplica un filtro a una variable', 'Concatena strings', 'Comenta código', 1, 10, 'liquid-sintaxis'),
('¿Cómo se comenta código en Liquid?', '{# comentario #}', '<!-- comentario -->', '{% comment %} comentario {% endcomment %}', '// comentario', 2, 10, 'liquid-sintaxis'),
('¿Cuál es el objeto global en Liquid que contiene la información de la tienda?', 'store', 'shop', 'global', 'settings', 1, 10, 'liquid-sintaxis'),
('¿Qué etiqueta se usa para iterar sobre una colección de productos en Liquid?', '{% loop %}', '{% foreach %}', '{% for %}', '{% iterate %}', 2, 10, 'liquid-sintaxis'),
('¿Cómo se asigna un valor a una variable en Liquid?', '{% set var = ''valor'' %}', '{% assign var = ''valor'' %}', '{{ var = ''valor'' }}', '{% let var = ''valor'' %}', 1, 10, 'liquid-sintaxis'),
('¿Qué filtro se usa para convertir un texto a mayúsculas en Liquid?', 'upcase', 'upper', 'capitalize', 'uppercase', 0, 10, 'liquid-sintaxis'),
('¿Cómo capturas un bloque de texto en una variable en Liquid?', '{% capture var %}...{% endcapture %}', '{% assign block var %}...{% endassign %}', '{% block var %}...{% endblock %}', '{% save var %}...{% endsave %}', 0, 15, 'liquid-sintaxis'),
('¿Qué hace el tag {% include %} en Liquid (obsoleto)?', 'Importa una librería de JS', 'Inserta un snippet', 'Incluye una app de terceros', 'Carga un producto', 1, 15, 'liquid-sintaxis'),
('¿Qué tag se recomienda usar en lugar de {% include %} en versiones modernas de Shopify?', '{% insert %}', '{% require %}', '{% render %}', '{% snippet %}', 2, 15, 'liquid-sintaxis'),
('¿Cuál de estos es un tipo de dato válido en Liquid?', 'Array', 'String', 'Number', 'Todos los anteriores', 3, 10, 'liquid-sintaxis'),
('¿Cómo verificas si una variable está vacía en Liquid?', '{% if var == empty %}', '{% if var == blank %}', '{% if var == null %}', '{% if var == '''' %}', 1, 15, 'liquid-sintaxis'),
('¿Qué filtro se usa para dar formato de dinero a un número en Liquid?', 'money', 'currency', 'format_money', 'price', 0, 10, 'liquid-sintaxis'),
('¿Qué objeto Liquid se usa para acceder a los ajustes del tema?', 'theme.settings', 'settings', 'shop.theme', 'configuration', 1, 15, 'liquid-sintaxis'),
('¿Qué hace el operador ''contains'' en Liquid?', 'Suma dos variables', 'Comprueba si un string o array incluye una subcadena o elemento', 'Comprueba si una variable existe', 'Concatena strings', 1, 15, 'liquid-sintaxis'),
('Si quieres mostrar los primeros 3 productos de una colección, ¿qué filtro o parámetro usas en el for?', '{% for p in collection limit:3 %}', '{% for p in collection max:3 %}', '{% for p in collection stop:3 %}', '{% for p in collection first:3 %}', 0, 15, 'liquid-sintaxis'),
('¿Qué es ''paginate'' en Liquid?', 'Un filtro para cortar texto', 'Un bloque para dividir grandes colecciones de productos en múltiples páginas', 'Un objeto de orden', 'Un tipo de menú', 1, 15, 'liquid-sintaxis'),
('¿Qué hace el filtro ''default''?', 'Establece un valor por defecto si la variable está vacía o no existe', 'Elimina la variable', 'Muestra un error', 'Convierte la variable a string', 0, 10, 'liquid-sintaxis'),
('¿Cómo se escribe un bloque ''else if'' en Liquid?', '{% elseif %}', '{% else if %}', '{% elsif %}', '{% elif %}', 2, 15, 'liquid-sintaxis'),
('¿Qué filtro usarías para convertir una fecha a un formato legible?', 'time', 'date', 'format_date', 'strftime', 1, 10, 'liquid-sintaxis'),
('¿Qué devuelve el filtro ''handleize''?', 'Convierte un texto en un formato amigable para URL (minúsculas, guiones)', 'Crea un producto nuevo', 'Devuelve el ID', 'Borra los espacios', 0, 15, 'liquid-sintaxis'),
('¿Cómo obtienes el primer elemento de un array en Liquid?', 'array.0', 'array[1]', 'array.first', 'first(array)', 2, 10, 'liquid-sintaxis'),
('¿Qué hace el filtro ''strip_html''?', 'Añade etiquetas HTML', 'Borra todo el texto', 'Elimina todas las etiquetas HTML de un string', 'Convierte texto a HTML', 2, 10, 'liquid-sintaxis'),
('¿Qué hace el filtro ''where'' en Liquid?', 'Crea una consulta SQL', 'Filtra un array de objetos según el valor de una propiedad', 'Busca en Google', 'Redirige a otra página', 1, 15, 'liquid-sintaxis'),
('¿Qué hace el filtro ''map'' en Liquid?', 'Muestra un mapa de Google', 'Extrae una propiedad específica de todos los objetos en un array (ej. extraer solo los títulos)', 'Ubica la tienda', 'Convierte un string a un array', 1, 15, 'liquid-sintaxis'),

('¿Qué es un SKU en la gestión de inventario?', 'Una pasarela de pago', 'Un código de barras universal', 'Una unidad de seguimiento de stock', 'Un impuesto', 2, 10, 'productos-variantes'),
('¿Cuántas opciones (ej. Talla, Color) permite Shopify por defecto por producto?', '1', '2', '3', 'Ilimitadas', 2, 15, 'productos-variantes'),
('¿Cuántas variantes en total puede tener un producto en Shopify por defecto?', '50', '100', '200', '500', 1, 15, 'productos-variantes'),
('Si un producto tiene 3 colores y 4 tallas, ¿cuántas variantes se crean?', '7', '12', '3', '4', 1, 10, 'productos-variantes'),
('¿Qué objeto en Liquid representa una variante individual de un producto?', 'product.variant', 'variant', 'product.options', 'item.variant', 1, 15, 'productos-variantes'),
('¿Qué indica la propiedad variant.inventory_quantity?', 'El precio de la variante', 'El peso de la variante', 'La cantidad en stock de la variante', 'El número de SKU', 2, 10, 'productos-variantes'),
('¿Qué significa ''Continuar vendiendo cuando esté agotado'' en Shopify?', 'Que el producto se oculta', 'Que los clientes pueden hacer pre-pedidos sin stock', 'Que el precio cambia a 0', 'Que se desactiva el SKU', 1, 10, 'productos-variantes'),
('¿Qué es un ''Vendor'' en un producto de Shopify?', 'El precio de coste', 'La marca o proveedor del producto', 'El tipo de producto', 'El peso para el envío', 1, 10, 'productos-variantes'),
('¿Para qué se utilizan los ''Tags'' (Etiquetas) en los productos?', 'Para organizar y filtrar productos', 'Para definir el precio', 'Para asignar el stock', 'Para crear el SKU', 0, 10, 'productos-variantes'),
('¿Qué formato de imagen recomienda Shopify para productos?', 'BMP', 'TIFF', 'WebP o JPEG', 'SVG', 2, 10, 'productos-variantes'),
('¿Qué es una colección ''Automatizada'' en Shopify?', 'Una colección que los clientes crean', 'Una colección que añade productos basados en condiciones', 'Una colección que cambia de precio', 'Una colección vacía', 1, 10, 'productos-variantes'),
('¿Qué objeto de Liquid representa una colección?', 'category', 'collection', 'group', 'product_list', 1, 10, 'productos-variantes'),
('¿Cómo accedes a todos los productos de una colección en Liquid?', 'collection.items', 'collection.all', 'collection.products', 'collection.list', 2, 10, 'productos-variantes'),
('¿Qué límite de productos tiene Shopify en sus planes estándar?', '100', '10,000', '100,000', 'No hay límite estricto de productos', 3, 10, 'productos-variantes'),
('¿Qué son las ''Ubicaciones'' (Locations) en Shopify?', 'Los idiomas de la tienda', 'Lugares físicos o apps donde se gestiona inventario y se preparan pedidos', 'Las direcciones de los clientes', 'Las zonas de envío', 1, 10, 'productos-variantes'),

('En el plan estándar de Shopify, ¿qué parte del checkout puedes modificar usando código HTML/CSS libremente?', 'Todo el checkout', 'Solo la cabecera', 'Ninguna parte, solo estilos visuales desde el editor', 'El botón de pago', 2, 15, 'checkout-configuracion'),
('¿Qué plan de Shopify permite modificar el checkout extensivamente (Checkout Extensibility)?', 'Shopify Basic', 'Shopify Plan', 'Advanced Shopify', 'Shopify Plus', 3, 20, 'checkout-configuracion'),
('¿Dónde configuras si el número de teléfono es obligatorio en el checkout?', 'En la configuración de Envíos', 'En la configuración de Pantalla de pago', 'En el editor de temas', 'En la configuración de Impuestos', 1, 10, 'checkout-configuracion'),
('¿Qué es un carrito abandonado?', 'Un pedido reembolsado', 'Un usuario que añade productos pero no completa el pago', 'Un producto sin stock', 'Una devolución', 1, 10, 'checkout-configuracion'),
('¿Puede Shopify enviar correos automáticos de carritos abandonados?', 'Sí, está integrado de forma nativa', 'No, necesitas una app de terceros', 'Solo en Shopify Plus', 'Solo si el cliente ya ha comprado antes', 0, 15, 'checkout-configuracion'),
('¿Qué estado tiene un pedido cuando el pago fue exitoso pero no se ha enviado?', 'Completado', 'Pendiente de pago', 'No preparado (Unfulfilled)', 'Archivado', 2, 15, 'checkout-configuracion'),
('¿Qué es el ''Fulfillment'' en Shopify?', 'El proceso de preparar y enviar el pedido', 'El reembolso del pedido', 'El pago del pedido', 'La creación de un producto', 0, 10, 'checkout-configuracion'),
('¿Qué objeto de Liquid se usa en la página del carrito?', 'cart', 'basket', 'order', 'checkout', 0, 10, 'checkout-configuracion'),
('¿Cómo iteras sobre los artículos del carrito en Liquid?', '{% for item in cart.items %}', '{% for product in cart.products %}', '{% for line in cart.lines %}', '{% for item in checkout.items %}', 0, 15, 'checkout-configuracion'),
('¿Qué hace cart.total_price?', 'Devuelve el peso total', 'Devuelve el precio total en formato moneda', 'Devuelve el precio total en centavos', 'Devuelve los impuestos', 2, 15, 'checkout-configuracion'),
('¿Qué es Shopify Payments?', 'Una app de terceros', 'La pasarela de pago nativa de Shopify', 'Un método de envío', 'Un plan de suscripción', 1, 10, 'checkout-configuracion'),
('Si usas una pasarela de pago externa en lugar de Shopify Payments, ¿qué ocurre?', 'Shopify no te deja vender', 'Shopify te cobra una comisión adicional por transacción', 'Es gratis', 'Solo puedes vender en tu país', 1, 20, 'checkout-configuracion'),

('¿Qué es Online Store 2.0 (OS 2.0)?', 'La segunda versión de Shopify', 'La nueva arquitectura de temas que permite bloques y secciones en todas las páginas', 'Una actualización de precios', 'Un nuevo tema predeterminado', 1, 15, 'os2-arquitectura'),
('En OS 2.0, ¿qué formato de archivo se usa para las plantillas principales (ej. product)?', '.liquid', '.html', '.json', '.xml', 2, 20, 'os2-arquitectura'),
('¿Qué es una ''Sección'' en un tema de Shopify?', 'Un bloque de código reutilizable que puede ser configurado en el editor de temas', 'Un producto', 'Un artículo del blog', 'Una pasarela de pago', 0, 10, 'os2-arquitectura'),
('En el esquema de una sección {% schema %}, ¿qué lenguaje se utiliza?', 'XML', 'YAML', 'JSON', 'Markdown', 2, 15, 'os2-arquitectura'),
('¿Cómo incluyes una sección estática en Liquid?', '{% include ''header'' %}', '{% section ''header'' %}', '{% require ''header'' %}', '{% load ''header'' %}', 1, 15, 'os2-arquitectura'),
('¿Qué hace la carpeta ''assets'' en un tema de Shopify?', 'Guarda los productos', 'Guarda los pedidos', 'Almacena CSS, JS e imágenes del tema', 'Guarda los clientes', 2, 10, 'os2-arquitectura'),
('¿Qué hace el filtro | asset_url?', 'Genera la URL de un producto', 'Devuelve la URL de una imagen en la carpeta assets en el CDN', 'Redirige al inicio', 'Crea un enlace de pago', 1, 10, 'os2-arquitectura'),
('¿Para qué sirve la carpeta ''locales'' en un tema?', 'Para almacenar direcciones IP', 'Para archivos JSON de traducciones (multidioma)', 'Para guardar ubicaciones físicas de la tienda', 'Para guardar monedas', 1, 15, 'os2-arquitectura'),
('¿Qué es un ''Snippet'' en Shopify?', 'Un pequeño fragmento de código Liquid reutilizable', 'Una imagen pequeña', 'Un descuento temporal', 'Una variante de producto', 0, 10, 'os2-arquitectura'),
('¿En qué carpeta se guardan los snippets?', 'templates/', 'sections/', 'snippets/', 'assets/', 2, 10, 'os2-arquitectura'),
('¿Qué son los App Blocks en OS 2.0?', 'Bloques de construcción de plástico', 'Permiten a las apps inyectar código visualmente en el tema sin modificar los archivos Liquid directamente', 'Bloqueadores de anuncios', 'Apps que bloquean fraudes', 1, 20, 'os2-arquitectura'),

('¿Qué es un ''Metafield'' en Shopify?', 'Un campo personalizado para añadir información extra a productos, clientes o pedidos', 'Un campo de fuerza', 'Una etiqueta HTML', 'Una regla de envío', 0, 15, 'intro-ecommerce'),
('¿Dónde modificas el Título SEO de un producto en Shopify?', 'En la configuración general', 'Al final de la página de edición del producto (Buscadores)', 'En el tema Liquid exclusivamente', 'En la pasarela de pago', 1, 10, 'intro-ecommerce'),
('¿Qué genera Shopify automáticamente para el SEO?', 'Sitemap.xml y robots.txt', 'Páginas de Wikipedia', 'Cuentas de Instagram', 'Artículos de blog', 0, 15, 'intro-ecommerce'),
('¿Puedes cambiar la estructura de la URL base de un producto (ej. /products/mi-producto)?', 'Sí, completamente', 'No, el prefijo /products/ es fijo en Shopify', 'Solo en Shopify Plus', 'Solo instalando una App', 1, 20, 'intro-ecommerce'),
('¿Qué es un código de descuento automático?', 'Un código que el cliente debe escribir a mano', 'Un descuento que se aplica solo en el carrito si se cumplen las condiciones', 'Un descuento falso', 'Una tarjeta de regalo', 1, 10, 'intro-ecommerce'),
('¿Qué es una tarjeta de regalo (Gift Card) en Shopify?', 'Un producto físico que se envía por correo', 'Un producto especial cuyo valor se puede usar como método de pago', 'Un cupón de descuento de porcentaje', 'Una forma de donar a ONGs', 1, 10, 'intro-ecommerce'),
('¿Shopify incluye un sistema de blog integrado?', 'Sí', 'No', 'Solo mediante apps', 'Solo en el plan avanzado', 0, 10, 'intro-ecommerce'),
('¿Qué es el objeto ''linklist'' en Liquid?', 'Una lista de productos', 'Un menú de navegación', 'Una lista de clientes', 'Los enlaces de redes sociales', 1, 15, 'intro-ecommerce'),
('¿Qué información guarda Shopify sobre un cliente?', 'Historial de pedidos, direcciones, nombre y email', 'Contraseña en texto plano', 'Datos de tarjeta de crédito completos', 'Su historial de navegación', 0, 10, 'intro-ecommerce'),
('¿Qué son los ''Tags'' de cliente?', 'Etiquetas para segmentar clientes (ej. VIP, Mayorista)', 'Nombres de usuario', 'Las contraseñas cifradas', 'Los productos que ha comprado', 0, 10, 'intro-ecommerce'),
('¿Dónde descargas aplicaciones oficiales para Shopify?', 'Google Play', 'App Store de Apple', 'Shopify App Store', 'En el editor de temas', 2, 10, 'intro-ecommerce'),
('¿Qué es una ''Custom App'' (App Personalizada) en Shopify?', 'Una app que está en la App Store', 'Una app desarrollada específicamente para una tienda y que no se publica en la App Store', 'Una app de diseño visual', 'Un tema a medida', 1, 15, 'intro-ecommerce'),
('¿Qué es Shopify CLI?', 'Una interfaz de línea de comandos para construir temas y apps de Shopify rápidamente', 'Un lenguaje de programación', 'Una pasarela de pago', 'Un tema gratuito', 0, 15, 'intro-ecommerce'),
('¿En qué lenguaje está escrito el núcleo del backend de Shopify?', 'PHP', 'Node.js', 'Ruby on Rails', 'Java', 2, 20, 'intro-ecommerce'),
('¿Qué tipo de plataforma es Shopify?', 'IaaS', 'SaaS (Software as a Service)', 'Open Source descargable', 'Un plugin de WordPress', 1, 10, 'intro-ecommerce'),
('¿Qué es Shopify POS?', 'Point of Sale, un sistema para vender en tiendas físicas sincronizado con la tienda online', 'Un tipo de producto', 'Un impuesto sobre ventas', 'Position of Store', 0, 10, 'intro-ecommerce'),
('¿Qué es un ''Redirect'' (Redireccionamiento) en Shopify?', 'Un cambio de color', 'Una regla para enviar a los usuarios de una URL antigua a una nueva (ej. error 404 a otra página)', 'Un reembolso automático', 'Un código de envío gratis', 1, 10, 'intro-ecommerce');


-- New Questions for all 50 modules
INSERT INTO questions (question_text, option_0, option_1, option_2, option_3, correct_answer_index, xp_reward, module_slug) VALUES
('¿Qué significa que Shopify sea una plataforma SaaS?', 'Software as a Service', 'System as a Service', 'Service as a System', 'Software and System', 0, 20, 'intro-ecommerce'),
('¿Cuál es el motor de base de datos principal que usa Shopify?', 'MySQL', 'PostgreSQL', 'MongoDB', 'Oracle', 0, 20, 'arquitectura-shopify'),
('¿Qué plan de Shopify es el nivel Enterprise?', 'Shopify Plus', 'Advanced Shopify', 'Basic Shopify', 'Starter', 0, 20, 'planes-precios'),
('¿En qué sección del admin se configuran los prefijos de pedido?', 'Información de la tienda', 'Pantalla de pago', 'Envíos', 'Mercados', 0, 20, 'configuracion-inicial'),
('¿A qué IP debe apuntar el registro A de un dominio de terceros?', '23.227.38.65', '127.0.0.1', '1.1.1.1', '8.8.8.8', 0, 20, 'gestion-dominios'),
('¿Cuál es el límite máximo de variantes por producto en Shopify estándar?', '50', '100', '200', '500', 1, 20, 'productos-variantes'),
('¿Qué característica es exclusiva de las colecciones manuales?', 'Ordenación personalizada drag-and-drop', 'Uso de etiquetas para filtrar', 'Filtros por precio', 'Sincronización con Google', 0, 20, 'colecciones-manuales'),
('¿Qué operador lógico se usa para requerir que se cumplan TODAS las condiciones?', 'AND', 'OR', 'XOR', 'NOT', 0, 20, 'colecciones-automatizadas'),
('¿Cómo se llaman los lugares físicos en Shopify donde rastreas stock?', 'Locations (Ubicaciones)', 'Warehouses', 'Stores', 'Puntos de venta', 0, 20, 'inventario-ubicaciones'),
('¿Cuál es el límite máximo de tags recomendado por producto?', '250', '100', '500', '1000', 0, 20, 'etiquetas-tags'),
('¿Qué tres elementos componen la estructura de un Metafield?', 'Namespace, Key y Value', 'Title, Slug y Body', 'ID, Name y Date', 'Tag, Category y Price', 0, 20, 'metafields-intro'),
('¿Qué ventaja ofrecen los Metaobjects sobre los Metafields?', 'Pueden generar páginas dinámicas propias', 'Son más baratos', 'No requieren API', 'Solo funcionan en Plus', 0, 20, 'metaobjects-intro'),
('¿Qué lenguaje se usa para crear segmentos dinámicos de clientes?', 'ShopifyQL', 'SQL', 'Javascript', 'Python', 0, 20, 'clientes-segmentacion'),
('¿Qué funcionalidad es clave en el modelo B2B de Shopify?', 'Catálogos de precios específicos', 'Venta por Instagram', 'Envío gratis siempre', 'Chat en vivo', 0, 20, 'b2b-shopify'),
('¿Qué app nativa de Shopify acelera el checkout en 1 clic?', 'Shop App', 'Facebook Channel', 'Google Channel', 'Messenger', 0, 20, 'canales-venta'),
('¿Qué dispositivo propio de Shopify permite vender en físico?', 'POS Go', 'Shopify Watch', 'Shopify Phone', 'Shopify Tablet', 0, 20, 'shopify-pos'),
('¿Qué estado financiero indica que los fondos están retenidos pero no cobrados?', 'Authorized', 'Paid', 'Pending', 'Voided', 0, 20, 'pedidos-fulfillment'),
('¿Qué es una RMA?', 'Autorización de devolución de mercancía', 'Regla de marketing avanzado', 'Registro de marca asociado', 'Recibo de monto anual', 0, 20, 'devoluciones-reembolsos'),
('¿Cómo permite Markets manejar múltiples países en una tienda?', 'Dominios y subcarpetas específicas', 'Varias bases de datos', 'Cuentas de hosting separadas', 'Apps de traducción externas solamente', 0, 20, 'shopify-markets'),
('¿Qué es el ''Nexus'' en el contexto de impuestos de EE.UU.?', 'Presencia física o económica en un estado', 'Una conexión de internet', 'Un modelo de datos', 'Un puerto de red', 0, 20, 'impuestos-taxes'),
('¿Para qué sirven los perfiles de envío?', 'Agrupar productos con tarifas diferentes', 'Crear perfiles de usuario', 'Sincronizar con redes sociales', 'Configurar el logo de la empresa', 0, 20, 'envios-zonas'),
('¿Qué pasarela nativa evita comisiones adicionales por transacción?', 'Shopify Payments', 'PayPal', 'Stripe', 'Authorize.net', 0, 20, 'pasarelas-pago'),
('¿Qué se puede configurar nativamente en el checkout estándar?', 'Logo, colores y fuentes', 'Código HTML libre', 'Scripts de seguimiento PHP', 'Nuevos pasos de pago', 0, 20, 'checkout-configuracion'),
('¿En qué lenguaje se construyen las Checkout UI Extensions?', 'React (Javascript)', 'Liquid', 'Ruby', 'PHP', 0, 20, 'checkout-extensibility'),
('¿Qué novedad permite Shopify con los descuentos recientemente?', 'Combinar múltiples tipos de descuentos', 'Descuentos de 200%', 'Solo 1 descuento por vida', 'Descuentos que pagan al cliente', 0, 20, 'descuentos-cupones'),
('¿Por qué son mejores los descuentos automáticos para la conversión?', 'Eliminan la fricción de buscar códigos', 'Son más caros', 'Requieren más pasos', 'Solo funcionan en móvil', 0, 20, 'descuentos-automaticos'),
('¿Cómo se consideran las Gift Cards contablemente antes de ser canjeadas?', 'Pasivo diferido', 'Activo circulante', 'Gasto de marketing', 'Ingreso neto', 0, 20, 'tarjetas-regalo'),
('¿Cuál es el flujo de email marketing más crítico?', 'Carrito abandonado', 'Bienvenida', 'Cumpleaños', 'Newsletter semanal', 0, 20, 'marketing-basico'),
('¿Qué archivos SEO genera Shopify automáticamente?', 'sitemap.xml y robots.txt', 'index.html', 'style.css', 'script.js', 0, 20, 'seo-basico'),
('¿Cuál es el código HTTP para una redirección permanente?', '301', '404', '200', '500', 0, 20, 'redirecciones-301'),
('¿Qué mide la Tasa de Conversión (CR)?', '% de sesiones que acaban en compra', 'Número de visitas', 'Velocidad de la web', 'Seguidores en Instagram', 0, 20, 'analitica-reportes'),
('¿Quién creó originalmente el lenguaje Liquid?', 'Shopify', 'Wordpress', 'Adobe', 'Microsoft', 0, 20, 'liquid-sintaxis'),
('¿Qué filtro se usa para optimizar imágenes en el CDN?', 'image_url', 'img_src', 'resize', 'crop', 0, 20, 'liquid-filtros'),
('¿Cuál es el límite de elementos de un bucle ''for'' sin paginación?', '50', '100', '500', '1000', 0, 20, 'liquid-bucles'),
('¿En qué formato están las plantillas en OS 2.0?', 'JSON', 'Liquid', 'HTML', 'XML', 0, 20, 'os2-arquitectura'),
('¿Qué tag de Liquid define el editor visual de una sección?', '{% schema %}', '{% section %}', '{% settings %}', '{% design %}', 0, 20, 'os2-secciones'),
('¿Qué ventaja tienen los App Blocks?', 'No dejan basura al desinstalar la app', 'Son más rápidos que Liquid', 'Hacen que la app sea gratis', 'Solo funcionan en PC', 0, 20, 'os2-app-blocks'),
('¿Qué comando inicia el desarrollo local de temas?', 'shopify theme dev', 'shopify theme start', 'shopify theme push', 'shopify theme pull', 0, 20, 'shopify-cli'),
('¿Qué ocurre al hacer ''git push'' en una rama conectada?', 'Shopify actualiza el tema automáticamente', 'Se borra la tienda', 'Nada, es manual', 'Se envía un email al soporte', 0, 20, 'github-integration'),
('¿Qué framework usa Hydrogen?', 'Remix (React)', 'Next.js', 'Vue.js', 'Angular', 0, 20, 'hydrogen-oxygen'),
('¿Qué tecnología usa la Storefront API?', 'GraphQL', 'REST', 'SOAP', 'Websockets', 0, 20, 'storefront-api'),
('¿Por qué GraphQL es preferible a REST en Shopify?', 'Evita el Over-fetching de datos', 'Es más antiguo', 'Solo funciona en PHP', 'No requiere tokens', 0, 20, 'admin-api-rest'),
('¿Qué header se usa para validar la autenticidad de un webhook?', 'X-Shopify-Hmac-Sha256', 'X-Auth-Token', 'Content-Type', 'User-Agent', 0, 20, 'webhooks-eventos'),
('¿Dónde se instalan las Custom Apps?', 'Directamente en el admin de una tienda', 'En la App Store pública', 'En Google Play', 'No se instalan', 0, 20, 'custom-apps'),
('¿Qué API se usa para cobrar a los comerciantes en apps públicas?', 'Billing API', 'Payment API', 'Transaction API', 'Money API', 0, 20, 'public-apps'),
('¿Cuál es la estructura de una automatización en Flow?', 'Trigger -> Condition -> Action', 'Start -> Stop -> End', 'Input -> Process -> Output', 'Do -> While -> Repeat', 0, 20, 'shopify-flow'),
('¿En qué se compilan las Shopify Functions?', 'WebAssembly (WASM)', 'Javascript', 'Python', 'C#', 0, 20, 'shopify-functions'),
('¿Dónde se ejecutan los nuevos píxeles de tracking?', 'En un Sandbox aislado (Web Worker)', 'Directamente en el DOM', 'En el servidor', 'En la base de datos', 0, 20, 'pixels-tracking'),
('¿Qué mide el LCP?', 'El tiempo de carga del elemento visual más grande', 'El número de imágenes', 'El tamaño del JS', 'El retraso del primer clic', 0, 20, 'optimizacion-rendimiento'),
('¿Qué previene el análisis de fraude nativo?', 'Chargebacks (Contracargos)', 'Caídas del servidor', 'Virus', 'Spam en comentarios', 0, 20, 'seguridad-fraude');
