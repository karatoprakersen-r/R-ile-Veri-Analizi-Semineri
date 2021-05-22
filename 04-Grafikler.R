#################################### BİLGİLENDİRME #################################### 
#Dr. Rabia KARATOPRAK ERŞEN tarafından hazırlanmıştır.
#Kastamonu Üniversitesi akademik personeli için 22-23 Mayıs 2021 tarihlerinde gerçekleşen "R ile Veri Analizi" semineri için hazırlanmıştır.
#Bu dosyayı başkaları ile paylaştığınız takdirde bu bilgilendirme yazısını silmeyiniz.
#İletişim: rabiakersen@kastamonu.edu.tr
######################################################################################
######################################################################################
#https://r4ds.had.co.nz/data-visualisation.html
#https://ggplot2.tidyverse.org
library(ggplot2)
############################## 1- Nokta Grafiği ve Temel Bilgiler ####################
BatiKaradeniz <- read.table( file = 'yas15_ustu_BatiKaradeniz.txt', 
                             header = TRUE, #veride sutun isimleri var.
                             sep = '\t') 
dim(BatiKaradeniz)
head(BatiKaradeniz[,1:6])


library(dplyr)
Kastamonu <- BatiKaradeniz %>%
    filter(ilKodu==37) #Kastamonu iline ait veriler
dim(Kastamonu)
Kastamonu[,1:6] #ilk 6 sütun

ggplot(data = Kastamonu) +
    geom_point(mapping = aes(x = Genel, y = Yil)) 

### x ve y Eksenleri
ggplot(data = Kastamonu) +
    geom_point(mapping = aes(x = Genel, y = Yil)) +
    scale_x_continuous("Nüfus", breaks = seq(280000, 320000, 3000)) + 
    scale_y_continuous("Yıl", breaks=seq(2008, 2019, 1))


### Çizgi grafiği 
ggplot(data = Kastamonu) +
    geom_point(mapping = aes(x = Genel, y = Yil)) +
    geom_line(mapping = aes(x = Genel, y = Yil)) +
    scale_x_continuous("Nüfus", breaks = seq(280000, 320000, 3000)) + 
    scale_y_continuous("Yıl", breaks=seq(2008, 2019, 1))

### Tamamlayıcı Ögeler
ggplot(data = Kastamonu) +
    geom_point(mapping = aes(x = Genel, y = Yil)) +
    geom_line(mapping = aes(x = Genel, y = Yil)) +
    scale_x_continuous("Nüfus", breaks = seq(280000, 320000, 4000)) + 
    scale_y_continuous("Yıl", breaks=seq(2008, 2019, 1)) +
    theme_linedraw()+
    labs(title = "Kastamonu İli Nüfus Grafiği",
         subtitle = "15 yaş üstü*",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018"
    )

### Kaydetme
gr.Kastamonu <- ggplot(data = Kastamonu) +
    geom_point(mapping = aes(x = Genel, y = Yil)) +
    geom_line(mapping = aes(x = Genel, y = Yil)) +
    scale_x_continuous("Nüfus", breaks = seq(280000, 320000, 4000)) + 
    scale_y_continuous("Yıl", breaks=seq(2008, 2019, 1)) +
    theme_linedraw()+
    labs(title = "Kastamonu İli Nüfus Grafiği",
         subtitle = "15 yaş üstü*",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018"
    )

ggsave("Kastamonu.png", gr.Kastamonu, width = 21, height = 15, units = "cm")


############################## 2- Nokta Grafiği: Kesikli ve Sürekli Değişken ################################
BatiKaradeniz2019 <- BatiKaradeniz %>% filter(Yil==2019) #Sadece 2019 yılına ait veri

ggplot(data = BatiKaradeniz2019) +
    geom_point(mapping = aes(x = Genel, y = ilAdi)) +
    scale_x_continuous("15 yaş üstü nüfus", 
                       breaks = seq(150000, 550000, 50000)) + 
    scale_y_discrete("İl")

ggplot(data = BatiKaradeniz2019) +
    geom_point(mapping = aes(y = Genel, x = reorder(ilAdi, Genel))) +
    scale_y_continuous("Nüfus", breaks = seq(150000, 550000, 50000)) + 
    scale_x_discrete("İl") 

gr.BK2019 <- ggplot(data = BatiKaradeniz2019) +
    geom_point(mapping = aes(x = Genel, y = reorder(ilAdi, Genel))) +
    scale_x_continuous("Nüfus", breaks = seq(150000, 550000, 50000)) + 
    scale_y_discrete("İl") +
    theme_linedraw() +
    labs(title = "Batı Karadeniz Bölümü 15 yaş üstü Nüfus Grafiği",
         subtitle = "2019 Yılı*",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018"
    )

gr.BK2019


############################## 3- Grafik üzerinde gruplandırma ############################## 
BatiKaradeniz08_19 <- BatiKaradeniz %>% filter(Yil %in% c(2008, 2019))
BatiKaradeniz08_19$Yil <- as.factor(BatiKaradeniz08_19$Yil)

ggplot(data = BatiKaradeniz08_19) +
    geom_point(mapping = aes(x = Genel, y = reorder(ilAdi, Genel))) +
    facet_grid(Yil ~. ) +
    scale_x_continuous("Nüfus", breaks = seq(150000, 550000, 50000)) + 
    scale_y_discrete("İl") +
    theme_linedraw() +
    labs(title = "Batı Karadeniz Bölümü 15 yaş üstü Nüfus Grafiği",
         #subtitle = "",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018"
    )

#`color()` fonksiyonu
ggplot(data = BatiKaradeniz08_19) +
    geom_point(mapping = aes(x = Genel, 
                             y = reorder(ilAdi, Genel), color=Yil)) +
    scale_x_continuous("Nüfus", breaks = seq(150000, 550000, 50000)) + 
    scale_y_discrete("İl") +
    theme_linedraw() +
    labs(title = "Batı Karadeniz Bölümü 15 yaş üstü Nüfus Grafiği",
         #subtitle = "",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018"
    )
#Soru: Bu noktalari nasil cizgi grafigi haline donustururuz?
 

#`shape()` fonksiyonu
ggplot(data = BatiKaradeniz08_19) +
    geom_point(mapping = aes(x = Genel, 
                             y = reorder(ilAdi, Genel), shape=Yil)) +
    scale_x_continuous("Nüfus", breaks = seq(150000, 550000, 50000)) + 
    scale_y_discrete("İl") +
    theme_linedraw() +
    labs(title = "Batı Karadeniz Bölümü 15 yaş üstü Nüfus Grafiği",
         #subtitle = "",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018"
    )
#Soru: Bu sekillerin farkli renkte olmasini nasil saglariz?
    
################################# Histogram ############################## 
yas15_2019 <- read.table( file = 'yas15_ustu_19.txt', 
                     header = TRUE, #veride sutun isimleri var.
                     sep = '\t') 
dim(yas15_2019)

ggplot(yas15_2019) +
    geom_histogram(mapping = aes(x=Genel), binwidth = 200000) +
    scale_x_continuous("Nüfus")+
    theme_linedraw() +
    labs(title = "Türkiye 15 yaş üstü Nüfus Grafiği",
         subtitle = "2019 Yılı*",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018",
         y = "Sayım"
    )

################################ Box-plot ############################## 
ggplot(BatiKaradeniz08_19) +
    geom_boxplot(mapping = aes(y=Genel, x=as.factor(Yil))) +
    scale_x_discrete(limits=c("2008", "2019")) +
    scale_y_continuous(breaks = seq(150000, 550000, 50000))+
    theme_linedraw() +
    labs(title = "Türkiye 15 yaş üstü Nüfus Grafiği",
         #subtitle = "2019 Yılı*",
         caption = "*http://www.tuik.gov.tr/PreTablo.do?alt_id=1018",
         y = "Nüfus",
         x = "Yıl"
    )
