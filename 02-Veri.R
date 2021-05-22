#################################### BİLGİLENDİRME #################################### 
#Dr. Rabia KARATOPRAK ERŞEN tarafından hazırlanmıştır.
#Kastamonu Üniversitesi akademik personeli için 22-23 Mayıs 2021 tarihlerinde gerçekleşen "R ile Veri Analizi" semineri için hazırlanmıştır.
#Bu dosyayı başkaları ile paylaştığınız takdirde bu bilgilendirme yazısını silmeyiniz.
#İletişim: rabiakersen@kastamonu.edu.tr
######################################################################################
######################################################################################
############################## 1- Veri ile İlgili Temel Komutlar #####################
rm(list = ls())
## Veriyi İçe Aktarma ####

veri <- read.table( file = 'yas15_ustu_BatiK_0819.txt', 
                    header = TRUE, #verinin ilk satırı değişken isimleri.
                    sep = '\t') #veriler arasinda tab tuşu ile oluşturulmuş boşluk var.

#fonksiyonun içerdiği değişkenleri tanıma
#??read.table


#excel dosyaları
# library(readxl)
# veri <- read_excel("Veri/yas15_ustu.xls", col_names = TRUE, skip = 3)


### Veriyi Disa Aktarma ####
write.table(veri, file = 'veri_kaydet.txt',
            col.names=TRUE, #sütun isimleri yazılır.
            sep = '\t', #veriler arasında tab tuşu ile boşluk oluşturur. '' veya ',' da olabilir.
            row.names = FALSE, #satır isimleri yazılmaz.
            quote = FALSE) #Veriler '' içinde yazılmaz.

# library(openxlsx)
# write.xlsx(veri, file = 'veri_kaydet.xlsx')


## Veri ile ilgili Komutlar  ####
dim(veri)
str(veri)
head(veri) #ilk 6 satır
tail(veri) #son 6 satır
View(veri)
colnames(veri) 


## Satır ve sütun seçme ####
veri[, c("Yil", "ilKodu", "ilAdi", "Genel", "Genel.Erkek", "Genel.Kadin")]
veri[, 1:6]
veri[ , c(1, 3, 5)] #1., 3., ve 5. değişken

veri$Yil

veri[,] 
veri[1,1] 
veri[1, ] 
veri[ ,1] 


## Kayıp Veriler ve TRUE ya da FALSE Geri Dönütü ####
veri[1,2]
is.na(veri[1,2]) #Kayıp veri mi değil mi?
#View(veri)

veri[1,1] 
is.na(veri[1,1])

colnames(veri) 
colnames(veri)[1] <- 'Yıl'
colnames(veri)[1] <- 'Yil'
colnames(veri) 


length(veri$ilAdi)
veri[,'ilAdi']
attr(veri$ilAdi, "levels")

summary(veri[,'ilAdi'])
length(summary(veri[,'ilAdi']))

############################## 2- dplyr ile Veri Düzenleme ################################
#https://r4ds.had.co.nz

#install.packages("dplyr")
library(dplyr)


### Değişken seçme  ####
genel <- select(veri, Yil, ilKodu, ilAdi, Genel, Genel.Erkek, Genel.Kadin)
dim(genel)
genel


select(genel, -ilKodu)
select(genel, -ilKodu, ilKodu)

genel_kdn <- select(veri, ends_with("Kadin"))  
colnames(genel_kdn)
colnames(select(veri, -ends_with("Erkek")))
colnames(select(veri, contains("Okur")))

genel_kdn <- dplyr::select(veri, ends_with("Kadin"))  

### Satır Seçme ####
summary(genel$Yil)
filter(genel, Yil==2019)
genel 


filter(genel, is.na(ilKodu))
filter(genel, !ilAdi=='Türkiye-Turkey')
filter(genel, Yil==2019 & !ilAdi=='Türkiye-Turkey')
filter(genel, Genel<200000)
filter(genel, Genel<200000 & Yil==2019)
filter(genel, ilKodu== 37 | ilAdi == 'Türkiye-Turkey')
filter(genel, ilKodu %in% c(57, 18, 78, 74)) #Batı Karadeniz



## Yeni Değişken oluşturma - mutate() ####
genel_19 <- filter(genel, Yil==2019 & !ilAdi=='Türkiye-Turkey')

mutate(genel_19, Kadin.yuzde = (Genel.Kadin/Genel)*100)
mutate(genel_19, il.yuzde = (Genel/62689647)*100, il.yuzde.2 = round(il.yuzde, 2))
mutate(genel_19, gen.250 = ifelse(Genel >= 250000, 1, 0))

mutate(genel_19, deg.yeni = case_when(Genel < 100000 ~ 0, 
                                      100000 <= Genel & Genel < 200000 ~ 1, 
                                      200000 <= Genel & Genel < 300000 ~ 2, 
                                      300000 <= Genel & Genel < 400000 ~ 3,
                                      400000 <= Genel ~ 4))

genel_19$test<- (genel_19$Genel/62689647)
genel_19
genel_19$test<- (genel_19$Genel/62689647)*100
genel_19


## Verileri Sıralama - arrange() ####
arrange(genel_19, Genel)
arrange(genel_19, desc(Genel))
arrange(genel, Yil, desc(Genel))



## %>% komutu ####
veri %>%
    dplyr::select(Yil, ilKodu, ilAdi, Genel, Genel.Erkek, Genel.Kadin) %>%
    filter(Yil==2019 & !ilAdi=='Türkiye-Turkey') %>%
    mutate(gen.250 = ifelse(Genel >= 250000, 1, 0)) %>%
    arrange(desc(Genel))

