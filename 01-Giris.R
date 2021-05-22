#################################### BİLGİLENDİRME #################################### 
#Dr. Rabia KARATOPRAK ERŞEN tarafından hazırlanmıştır.
#Kastamonu Üniversitesi akademik personeli için 22-23 Mayıs 2021 tarihlerinde gerçekleşen "R ile Veri Analizi" semineri için hazırlanmıştır.
#Bu dosyayı başkaları ile paylaştığınız takdirde bu bilgilendirme yazısını silmeyiniz.
#İletişim: rabiakersen@kastamonu.edu.tr
######################################################################################
######################################################################################
#################################### Kullanım şekilleri ############################## 

#bookdown kütüphanesi kullanılarak
#https://r4ds.had.co.nz

#shiny kütüphanesi
#https://shiny.rstudio.com/gallery/radiant.html
#https://abenedetti.shinyapps.io/bioNPS/

#Hesap makinesi
6 + 2 #toplama
6 - 2 #çıkarma
6 * 2 #çarpma
6 / 2 #bölme
6**2 #üslü çarpma
6^2 #üslü çarpma 

sqrt(36) #9'un karekökü
log(9, base = 3) # 9'un 3 tabanında logaritması
sum(1:3) #1, 2, ve 3 sayılarının toplanması

1:3 # ardışık sayılar için
c(1, 3, 4) #rastgele seçilmiş sayılar için 
sum(1:3) #toplama işlemi
sum(c(1, 2, 3))



#################################### Nesne Oluşturma #################################### 

x <- 4 #nesne oluşturma
x #nesneyi geri çağırma

6 + x
sqrt(x)

y <-2
x*y

#################################### R Kütüphaneleri #################################### 
#Bir kereliğine yüklenir.
#install.packages("tidyverse") 
#tidyverse eklentisine ihtiyaç duyduğumuz her oturum için bu komutu çalıştırmamız gerekir.
library(tidyverse) 
