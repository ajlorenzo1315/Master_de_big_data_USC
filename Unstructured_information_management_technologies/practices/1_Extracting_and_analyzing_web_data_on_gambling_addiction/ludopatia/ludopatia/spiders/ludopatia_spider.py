import scrapy


#class LudopatiaSpiderSpider(scrapy.Spider):
#    name = "ludopatia_spider"
#    allowed_domains = ["ludopatia.org"]
#    start_urls = ["https://ludopatia.org"]
#
#    def parse(self, response):
#        pass



class LudopatiaSpider(scrapy.Spider):
    name = "ludopatia_spider"
    start_urls = ['https://www.ludopatia.org/forum/default.asp']

    custom_settings = {
        'FEEDS': {
            'ludopatia_forum.json': {
                'format': 'json',
                'overwrite': True
            }
        },
    }

    def start_requests(self):
        url = "https://www.ludopatia.org/forum/default.asp"
        self.root_url = 'https://www.ludopatia.org/forum/'
        yield scrapy.Request(url, self.parse)

    def parse(self, response):
        print("URL de la página actual:", response.url)

        for forum in response.css('a[href^="forum_topics.asp"]'):
            forum_url = forum.css('a::attr(href)').get()
            forum_name = forum.css('a::text').get()
            forum_full_url = self.root_url + forum_url
            print(forum_name)

            yield response.follow(forum_full_url, callback=self.parse_forum)

    def parse_forum(self, response):
        print("URL de la página actual forum:", response.url)

        for forum in response.css('a[href^="forum_posts.asp"]'):
            forum_url = forum.css('a::attr(href)').get()
            forum_name = forum.css('a::text').get()
            forum_full_url = self.root_url + forum_url

            yield response.follow(forum_full_url, callback=self.parse_subforum)

        # Buscar el enlace "Siguiente" y seguirlo 
        next_page = response.xpath('//a[contains(text(), "Siguiente")]/@href').extract_first()
        if next_page:
            # Construir la URL completa
            yield response.follow(next_page, callback=self.parse_forum)

    def parse_subforum(self, response):
        print("URL de la página actual sub:", response.url)
        # Extraer el título del foro
        titulo_foro = response.xpath('//td[@class="heading"]/text()').get()

        # Extraer el asunto del tema
        asunto_tema = response.xpath('//span[@class="lgText"]/text()').get()

        mensajes = response.xpath('//td[@class="text" and @valign="top"]')
        autores = response.xpath('//span[@class="bold"]/text()').getall()

        for ind, mensaje in enumerate(mensajes):
            autor = autores[ind]
            fecha = mensaje.xpath('.//td[@class="smText"]/text()').get()
            texto = mensaje.xpath('.//text()').getall()

            # Filtrar y limpiar el texto de partes no deseadas
            texto_limpio = [t.strip() for t in texto if t.strip()]
            texto_final = " ".join(texto_limpio)

            if autor and fecha and texto_final:
                yield {
                    'autor': autor,
                    'fecha': fecha.strip(),
                    'texto': texto_final,
                    'titulo_foro': titulo_foro,
                    'asunto_tema': asunto_tema,
                }