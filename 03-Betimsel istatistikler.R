#################################### BİLGİLENDİRME #################################### 
#Dr. Rabia KARATOPRAK ERŞEN tarafından hazırlanmıştır.
#Kastamonu Üniversitesi akademik personeli için 22-23 Mayıs 2021 tarihlerinde gerçekleşen "R ile Veri Analizi" semineri için hazırlanmıştır.
#Bu dosyayı başkaları ile paylaştığınız takdirde bu bilgilendirme yazısını silmeyiniz.
#İletişim: rabiakersen@kastamonu.edu.tr
######################################################################################
######################################################################################
rm(list = ls())

veri <- read.table( file = 'yas15_ustu_BatiK_0819.txt', 
                    header = TRUE, #veride sütun isimleri var.
                    sep = '\t')           


colnames(veri)
summary(veri$Yil)


### Kesikli ya da Nitel Değişkenler
str(veri)

summary(veri[,'ilAdi']) 
length(summary(veri[,'ilAdi']))

summary(veri$Yil)
summary(as.factor(veri$Yil))

veri$ilKodu <- as.factor(veri$ilKodu)
summary(veri$ilKodu)
length(summary(as.factor(veri$ilKodu)))

### Sürekli Değişkenler
summary(veri$Genel)

mean(veri$Genel, na.rm = TRUE)
mean(veri[, "Genel"], na.rm = TRUE)
mean(veri$Genel)



sd(veri$Genel, na.rm = TRUE)
var(veri$Genel, na.rm = TRUE)
median(veri$Genel, na.rm = TRUE)
min(veri$Genel, na.rm = TRUE)
max(veri$Genel, na.rm = TRUE)
quantile(veri$Genel, na.rm = TRUE)
summary(veri$Genel)


### %>% komutu ve `summarise()` fonksiyonu
library(dplyr)
veri %>%
    dplyr::select(Yil, ilKodu, ilAdi, Genel, Genel.Erkek, Genel.Kadin) %>%
    filter(Yil==2019 & !ilAdi=='Türkiye-Turkey') %>%
    mutate(gen.250 = ifelse(Genel >= 250000, 1, 0)) %>%
    summarise(gen.ort = mean(Genel),
              gen.sd = sd(Genel),
              gen.max = max(Genel),
              gen.min = min(Genel),
              toplam = n()
    )

veri %>%
    dplyr::select(Yil, ilAdi, Genel, Genel.Erkek, Genel.Kadin) %>%
    filter(!ilAdi=='Türkiye-Turkey') %>%
    group_by(Yil) %>%
    summarise(gen.ort = mean(Genel),
              gen.sd = sd(Genel),
              gen.max = max(Genel),
              gen.min = min(Genel),
              toplam = n()
    )

