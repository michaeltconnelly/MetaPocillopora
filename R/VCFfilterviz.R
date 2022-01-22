vcfqvis <- function(vcf, ind_stats, loc_stats){

# plot missing data per indv ----
p1 <- ggplot(ind_stats, aes(x = MISS)) +
  geom_histogram(binwidth = .01, color = "black", fill = "grey95") +
  geom_vline(aes(xintercept = mean(MISS, na.rm = TRUE)),
             color = "black", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 0.5),
             color = "blue", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 0.95),
             color = "red", linetype = "dashed", size = 1) +
  labs(x = "missing data per indv") 

# plot Fis per indv ----
p2 <- ggplot(ind_stats, aes(x = Fis)) +
  geom_histogram(binwidth = .01, color = "black", fill = "grey95") +
  geom_vline(aes(xintercept = mean(Fis, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 0),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "Fis per indv") 

# plot read depth per indv ----
p3 <- ggplot(ind_stats, aes(x = MEAN_DEPTH)) +
  geom_histogram(binwidth = 2, color = "black", fill = "grey95") +
  geom_vline(aes(xintercept = mean(MEAN_DEPTH, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 20),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "mean read depth per indv")

# plot depth vs missing ----
p4 <- ggplot(ind_stats, aes(x = MEAN_DEPTH, y = MISS)) +
  geom_point() +
  geom_vline(aes(xintercept = mean(MEAN_DEPTH, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 20),
             color = "darkblue", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = mean(MISS, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = 0.5),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "mean depth per indv", y = "% missing data") 

# plot Fis vs missing data per indv ----
p5 <- ggplot(ind_stats, aes(x = Fis, y = MISS)) +
  geom_point() +
  geom_vline(aes(xintercept = mean(Fis, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 0),
             color = "darkblue", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = mean(MISS, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = 0.5),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "Fis per indv", y = "% missing data") 

# plot Fis vs mean depth per indv ----
p6 <- ggplot(ind_stats, aes(x = Fis, y = MEAN_DEPTH)) +
  geom_point() +
  geom_vline(aes(xintercept = mean(Fis, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 0),
             color = "darkblue", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = mean(MEAN_DEPTH, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = 20),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "Fis per indv", y = "mean depth per indv") 

# plot distribution missing data per locus ----
p7 <- ggplot(loc_stats, aes(x = MISS)) +
  geom_histogram(binwidth = 0.01, color = "black", fill = "grey95") +
  geom_vline(aes(xintercept = 0.95),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = mean(MISS, na.rm = TRUE)),
             color = "black", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 0.1),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "% missing data per locus") 

# plot distribution mean read depth ----
p8 <- ggplot(loc_stats, aes(x = MEAN_DEPTH)) +
  geom_histogram(binwidth = 2, color = "black", fill = "grey95") +
  geom_vline(aes(xintercept = mean(MEAN_DEPTH, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 20),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "mean read depth per locus")

# plot read depth vs missing data ----
p9 <- ggplot(loc_stats, aes(x = MEAN_DEPTH, y = MISS)) +
  geom_point() +
  geom_vline(aes(xintercept = mean(MEAN_DEPTH, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = 20),
             color = "darkblue", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = mean(MISS, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1) +
  geom_hline(aes(yintercept = 0.1),
             color = "darkblue", linetype = "dashed", size = 1) +
  labs(x = "mean depth per locus", y = "% missing data")

# plot no of SNPs per locus ----
p10 <- loc_stats %>%
  count(CHR) %>%
  ggplot(aes(x = n)) +
  geom_histogram(binwidth = 1, color = "black", fill = "grey95") +
  labs(x = "number of SNPs per locus")
temp <- loc_stats %>%
  count(CHR)

# plot number of SNPs per contig vs. mean depth ----
p11 <- left_join(temp, loc_stats) %>%
  ggplot() +
  geom_point(aes(x = n, y = MEAN_DEPTH)) +
  labs(x = "number of SNPs per contig", y = "mean depth")

# # plot depth vs SNP quality ----
# # loc_stats[match(loc_stats$CHR, site_qual$CHROM),]$MEAN_DEPTH
# 
# temp <- data.frame(loc_stats[(match(loc_stats$CHR, site_qual$CHROM)),]$MEAN_DEPTH, site_qual$QUAL) %>%
#   rename(depth = loc_stats.MEAN_DEPTH, qual = site_qual.QUAL)
# 
# p12 <- ggplot(temp, aes(x = depth, y = qual)) +
#   geom_point(size = 1) +
#   geom_vline(aes(xintercept = mean(depth, na.rm = TRUE)),
#              color = "red", linetype = "dashed", size = 1) +
#   geom_vline(aes(xintercept = 20),
#              color = "darkblue", linetype = "dashed", size = 1) +
#   geom_hline(aes(yintercept = mean(qual, na.rm = TRUE)),
#              color = "red", linetype = "dashed", size = 1) +
#   geom_hline(aes(yintercept = 20),
#              color = "darkblue", linetype = "dashed", size = 1) +
#   labs(x = "mean depth per locus", y = "SNP quality")

m1 <- multiplot(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, cols=2) # , p12
}

vcfqvis_miss <- function(vcf, ind_stats, loc_stats, title){
# Notes for future: standardize axes, fix larger viz function above to black, green, red lines
  
  # plot missing data per indv ----
  p1 <- ggplot(ind_stats, aes(x = MISS)) +
    geom_histogram(binwidth = .01, color = "black", fill = "grey95") +
    geom_vline(aes(xintercept = mean(MISS, na.rm = TRUE)),
               color = "black", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 0.5),
               color = "darkgreen", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 0.95),
               color = "red", linetype = "dashed", size = 1) +
    labs(x = "missing data per indv") 
  
  # plot missing data per locus ----
  p7 <- ggplot(loc_stats, aes(x = MISS)) +
    geom_histogram(binwidth = 0.01, color = "black", fill = "grey95") +
    geom_vline(aes(xintercept = mean(MISS, na.rm = TRUE)),
               color = "black", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 0.1),
               color = "darkgreen", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 0.95),
               color = "red", linetype = "dashed", size = 1) +
    labs(x = "% missing data per locus") 
  
  
  # plot depth vs missing per indv ----
  p4 <- ggplot(ind_stats, aes(x = MEAN_DEPTH, y = MISS)) +
    geom_point() +
    geom_vline(aes(xintercept = mean(MEAN_DEPTH, na.rm = TRUE)),
               color = "black", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 20),
               color = "darkgreen", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 5),
               color = "red", linetype = "dashed", size = 1) +
    #
    geom_hline(aes(yintercept = mean(MISS, na.rm = TRUE)),
               color = "black", linetype = "dashed", size = 1) +
    geom_hline(aes(yintercept = 0.5),
               color = "darkgreen", linetype = "dashed", size = 1) +
    geom_hline(aes(yintercept = 0.95),
               color = "red", linetype = "dashed", size = 1) +
    labs(x = "mean depth per indv", y = "% missing data") 
  
  
  # plot depth vs missing data per locus ----
  p9 <- ggplot(loc_stats, aes(x = MEAN_DEPTH, y = MISS)) +
    geom_point() +
    geom_vline(aes(xintercept = mean(MEAN_DEPTH, na.rm = TRUE)),
               color = "black", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 20),
               color = "darkgreen", linetype = "dashed", size = 1) +
    geom_vline(aes(xintercept = 5),
               color = "red", linetype = "dashed", size = 1) +
    #
    geom_hline(aes(yintercept = mean(MISS, na.rm = TRUE)),
               color = "black", linetype = "dashed", size = 1) +
    geom_hline(aes(yintercept = 0.1),
               color = "darkgreen", linetype = "dashed", size = 1) +
    geom_hline(aes(yintercept = 0.95),
               color = "red", linetype = "dashed", size = 1) +
    labs(x = "mean depth per locus", y = "% missing data")
  
  library(patchwork)
    m1 <- ((p1 + p7) / (p4 + p9)) + plot_annotation(title = title)
    print(m1)
  
  # m1 <- multiplot(p1, p4, p7, p9, cols=2)
}
