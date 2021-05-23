#################################### BİLGİLENDİRME #################################### 
#Dr. Rabia KARATOPRAK ERŞEN tarafından hazırlanmıştır.
#Kastamonu Üniversitesi akademik personeli için 22-23 Mayıs 2021 tarihlerinde gerçekleşen "R ile Veri Analizi" semineri için hazırlanmıştır.
#Bu dosyayı başkaları ile paylaştığınız takdirde bu bilgilendirme yazısını silmeyiniz.
#İletişim: rabiakersen@kastamonu.edu.tr
######################################################################################
######################################################################################
#Dalgaard, P. (2008). Introductory statistics with R. Springer-Verlag New York. doi:10.1007/978-0-387-79054-1

######################################## Basit Regresyon ############################## 

summary(pressure)
sd(pressure$temperature)
sd(pressure$pressure)

regres1 <- lm(pressure~temperature, data = pressure)
regres1

#`summary()` fonksiyonu ile katsayıya bağlı standart hata, *t* değeri,  olasılığı, $R^2$ gibi istatistikleri öğrenebiliriz. 
summary(regres1)

fitted(regres1)
resid(regres1)

hist(regres1$residuals)
plot(regres1)


