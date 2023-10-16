from keybert import KeyBERT

docs =  ["I like basketball", "I hate football", "I like Data Science"]

kw_model = KeyBERT() ### Inicialización del modelo, recomendado su uso en GPU

doc_embeddings, word_embeddings = kw_model.extract_embeddings(docs) ### No genera embeddings para todas las palabras

print(doc_embeddings.shape)
print(word_embeddings.shape)

keywords = kw_model.extract_keywords(docs)
print(keywords)
