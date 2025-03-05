# LME for infant 3 tempo, based off code from Jesse
# ALSO ASK JESSE ABOUT INDIVIDUAL TRIALS VS AVGs

library(tidyverse)
library(emmeans)
library(effects)
library(lme4)  # For linear mixed effects modeling
library(lmerTest)  # For F testing of LMER models
library(car)  # For qqPlot
library(performance)
library(insight)
library(effectsize)
library(ggplot2)
library(ggeffects)
setwd("C:/Users/erica/OneDrive/Documents/PNB/Research/Infant Rhythm EEG/Follow-up_21-22/Analysis_FinalSample/N=38_Aug2023/200-400ms_MaxPeak_Analysis/1-20Hz")

## PREPARE MMR DATA ##
data <- read.csv("mmr_data_lme.csv")
data <- mutate_if(data, is.character, as.factor)
data$participant <- as.factor(data$participant)
data$prime_group <- as.factor(data$prime_group)
data$beat_pos<- as.factor(data$beat_pos)
data$mus_class<- as.factor(data$mus_class)
options(contrasts = c("contr.sum","contr.poly"))

## TRY LME ##
# first attempt
model <- lmer(mmr_amp ~ beat_pos * prime_group * mus_class * chan + (1|participant), data=data, REML=FALSE)
# simpler model
# model<- lmer(mmr_amp ~ beat_pos * prime_group * chan + (1|participant), data=data, REML=FALSE)
step(model) # tries to reduce maximum model ... can tell it to keep certain effects.

# try now but with musical parent as the music factor.
# model <- lmer(mmr_amp ~ beat_pos * prime_group * mus_parent * chan + (1|participant), data=data, REML=FALSE)

reduced_model<-lmer(mmr_amp~beat_pos*prime_group*mus_class + beat_pos*chan*mus_class +(1|participant),data=data, REML=FALSE)
summary(reduced_model)
mns=lsmeans(reduced_model,pairwise~beat_pos|prime_group|mus_class, adjust="bon")
print(mns)
# effect sizes: 

# Normality of residuals (looks good I think?)
qqPlot(residuals(model))
hist(residuals(model))
# Homoscedasticity: Good
plot(fitted(model), residuals(model), xlab="Fitted Values", ylab="Residuals")
anova(model)
summary(model)
eta_squared(model, partial = TRUE)
contrasts(data$beat_pos)
contrasts(data$mus_class)
contrasts(data$prime_group)
contrasts(data$chan)

## Beat pos x prime group x mus class interaction
# Get means
mns = lsmeans(model, pairwise~beat_pos|prime_group|mus_class, adjust="bon") # but is bonferroni best choice? realizing it is plotting ALL the comparisons...
# mns = lsmeans(model, pairwise~beat_pos|prime_group|mus_parent, adjust="bon") # but is bonferroni best choice? realizing it is plotting ALL the comparisons...
comps = pairs(mns)
summary(comps, by = NULL, adjust = "bon") 
emm <- emmeans(model, ~ beat_pos | prime_group * mus_class)
emm_df <- as.data.frame(emm)  # Convert to dataframe

## PLOT beat position x prime group x music class.
# Collapse individual data across channels
data_avg <- data %>%
  group_by(participant, beat_pos, mus_class, prime_group) %>%
  summarize(mmr_amp = mean(mmr_amp, na.rm = TRUE), .groups = "drop")

# Ensure beat_pos is a factor
data_avg$beat_pos <- factor(data_avg$beat_pos, levels = c("4", "5"))
emm_df$beat_pos <- factor(emm_df$beat_pos, levels = c("4", "5"))

# Calculate jitter manually
set.seed(123)  # For consistent jitter
jitter_width <- 0.1
data_avg <- data_avg %>%
  mutate(jittered_pos = as.numeric(beat_pos) + runif(nrow(data_avg), -jitter_width, jitter_width))

ggplot() +
  # Boxplots (unchanged colors)
  geom_boxplot(data = data_avg, aes(x = beat_pos, y = mmr_amp, fill = beat_pos), 
               alpha = 0.3, outlier.shape = NA) +  
  
  # Jittered individual data points with different shapes for mus_class
  geom_point(data = data_avg, 
             aes(x = jittered_pos, y = mmr_amp, color = beat_pos, shape = mus_class),
             size = 2, alpha = 0.7) +  
  
  # Connect beat 4 and 5 with different line colors for prime_group
  geom_line(data = data_avg, 
            aes(x = jittered_pos, y = mmr_amp, group = participant, color = prime_group), 
            linewidth = 0.4, alpha = 0.7) +  
  
  # Facet by prime group and mus_class
  facet_wrap(mus_class ~ prime_group, 
             labeller = labeller(mus_class = c("0" = "Not in classes", "1" = "In Music Classes"),
                                 prime_group = c("2" = "Duple Group", "3" = "Triple Group"))) +
  
  # Custom colors (Red for Beat 4, Blue for Beat 5)
  scale_color_manual(values = c("4" = "red", "5" = "blue", "2" = "gray65", "3" = "gray40")) +  
  scale_fill_manual(values = c("4" = "red", "5" = "blue")) +  
  
  # Different point shapes for mus_class
  scale_shape_manual(values = c("0" = 16, "1" = 17)) +  
  
  labs(title = "Interaction of Beat Position, Prime Group, and Music Class",
       x = "Beat Position",
       y = "MMR Amplitude (Averaged Across Channels)",
       color = "Prime Group",
       fill = "Beat Position",
       shape = "Music Class") +
  
  theme(panel.background = element_blank())

ggsave("bp_prime_mus_class.png", dpi = 600)

## PLOT THE BEAT POS x MUS CLASS x CHAN INTERACTION
# Collapse individual data across channels
data_avg <- data %>%
  group_by(participant, beat_pos, mus_class, chan) %>%
  summarize(mmr_amp = mean(mmr_amp, na.rm = TRUE), .groups = "drop")

# Ensure factors
data_avg$beat_pos <- factor(data_avg$beat_pos, levels = c("4", "5"))
data_avg$chan <- factor(data_avg$chan, levels = c("FL", "FZ", "FR"))
data_avg$mus_class <- factor(data_avg$mus_class)  
emm_df$beat_pos <- factor(emm_df$beat_pos, levels = c("4", "5"))
emm_df$chan <- factor(emm_df$chan, levels = c("FL", "FZ", "FR"))

# Reshape data: Spread beat_pos into separate columns (for proper line connections)
data_wide <- data_avg %>%
  pivot_wider(names_from = beat_pos, values_from = mmr_amp, names_prefix = "beat")

ggplot() +
  # Boxplots (fixed overlap)
  geom_boxplot(data = data_avg, 
               aes(x = chan, y = mmr_amp, fill = beat_pos), 
               alpha = 0.3, outlier.shape = NA, 
               position = position_dodge(width = 0.9)) +  
  
  # Individual subject data points
  geom_point(data = data_avg, 
             aes(x = chan, y = mmr_amp, color = beat_pos, shape = mus_class),
             size = 2, alpha = 0.7, 
             position = position_jitterdodge(jitter.width = 0, dodge.width = 0.9)) +  
  
  # Corrected lines: Now connecting Beat 4 → Beat 5 within each channel!
  geom_segment(data = data_wide, 
               aes(x = as.numeric(chan) - 0.21, xend = as.numeric(chan) + 0.21, 
                   y = beat4, yend = beat5, 
                   group = participant),  
               linewidth = 0.3, alpha = 0.5) +  
  
  # Facet by mus_class (stacked vertically)
  facet_wrap(~mus_class, ncol = 1, 
             labeller = labeller(mus_class = c("0" = "Not in classes", "1" = "In Music Classes"))) +
  
  # Custom colors (Red for Beat 4, Blue for Beat 5)
  scale_color_manual(values = c("4" = "red", "5" = "blue")) +  
  scale_fill_manual(values = c("4" = "red", "5" = "blue")) +  
  
  # Different point shapes for mus_class
  scale_shape_manual(values = c("0" = 16, "1" = 17)) +  
  
  labs(title = "Interaction of Beat Position, Music Class, and Channel",
       x = "Channel",
       y = "MMR Amplitude",
       color = "Beat Position",
       fill = "Beat Position",
       shape = "Music Class") +

  theme(panel.background = element_blank())

ggsave("bp_chan_mus_class.png", dpi = 600)

# OR DO:
mns = lsmeans(model, pairwise~beat_pos|mus_class|chan, adjust="bon")
comps = pairs(mns)
summary(comps, by = NULL, adjust = "bon") 

# or for the 2-ways:
mns = lsmeans(model, pairwise~beat_pos|mus_class, adjust="bon")
comps = pairs(mns)
summary(comps, by = NULL, adjust = "bon") 

mns = lsmeans(model, pairwise~beat_pos|prime_group, adjust="bon")
comps = pairs(mns)
summary(comps, by = NULL, adjust = "bon") 

## now try with SSEPs/ITPC
## PREPARE SSEP/ITPC DATA ##
data <- read.csv("data_lme_freqs.csv")
data <- mutate_if(data, is.character, as.factor)
data$participant <- as.factor(data$participant)
data$prime_group <- as.factor(data$prime_group)
data$beat_pos<- as.factor(data$freq)
data$mus_class<- as.factor(data$mus_class)
options(contrasts = c("contr.sum","contr.poly"))

## TRY LME ##
# first attempt
ssep_model <- lmer(SSEP_pow ~ prime_group * mus_class * freq + (1|participant), data=data, REML=FALSE)
# ssep_model <- lmer(SSEP_pow ~ prime_group * mus_parent * freq + (1|participant), data=data, REML=FALSE)
# itpc_model <- lmer(ITPC ~ prime_group * mus_class * freq + (1|participant), data=data, REML=FALSE)


# only look at triple frequency, so no within subject effect now, which makes lme not appropriate:
subset_data <- subset(data, freq=='beat')
itpc_model <- aov(ITPC ~ prime_group * mus_class, data=subset_data)
# itpc_model <- aov(ITPC ~ prime_group * mus_parent, data=subset_data)
summary(itpc_model)
eta_squared(itpc_model, partial = TRUE)

contrasts(data$beat_pos)
contrasts(data$mus_class)
contrasts(data$prime_group)
contrasts(data$freq)

## SSEPs - RESIDUALS LOOK NOT GREAT
# Normality of residuals
resid_ssep = residuals(ssep_model)
qqPlot(resid_ssep)
hist(resid_ssep)
plot(fitted(ssep_model), resid_ssep, xlab="Fitted Values", ylab="Residuals")
check_normality(ssep_model, effects = "fixed")

# plot the residuals between the priming groups
plot( ssep_model, resid(., type = "response") ~ fitted(.) | prime_group*freq, id = 0.05, adj = -0.3 )
tapply(resid_ssep, data$prime_group, mean) # get mean residuals per group
anova_residuals = aov(resid_ssep~data$prime_group)
summary(anova_residuals)

## Not doing this now
# So, let's try transforming the data first
# install.packages('VGAM')
# library(VGAM)
# library(car)

# determine optimal lambda for yeojohnson transformation
# test_model <- lm(data$SSEP_pow~1)
# x = boxCox(test_model, family="yjPower", plotit = TRUE)
# data$SSEP_pow_yj = yeo.johnson(data$SSEP_pow, lambda = -1.65)
#ssep_model <- lmer(SSEP_pow_yj ~ prime_group * mus_class * freq + (1|participant), data=data, REML=FALSE)

# Summaries
anova(ssep_model)
summary(ssep_model)
mns = lsmeans(ssep_model, pairwise~prime_group|freq, adjdfe='satterthwaite', adjust="bon") # but is bonferroni best choice? realizing it is plotting ALL the comparisons...
print(mns)
mns = lsmeans(ssep_model, pairwise~freq, adjdfe='satterthwaite', adjust="bon") # but is bonferroni best choice? realizing it is plotting ALL the comparisons...
print(mns)
sseps_interaction <- lmer(SSEP_pow ~ prime_group * freq + (1|participant), data=data, REML=FALSE)
eta_squared(ssep_model, partial = TRUE)

e1 <- allEffects(sseps_interaction)
print(e1)
plot(e1)


## ITPC
# Normality of residuals
qqPlot(residuals(itpc_model))
hist(residuals(itpc_model))
# Homoscedasticity: Bimodal? Probs bc triple and duple peaks n.s.
plot(fitted(itpc_model), residuals(itpc_model), xlab="Fitted Values", ylab="Residuals")
plot( itpc_model, resid(., type = "response") ~ fitted(.) | prime_group*mus_class, id = 0.05, adj = -0.3 )

# Summaries
anova(itpc_model)
summary(itpc_model)
mns = lsmeans(itpc_model, pairwise~prime_group|mus_class|freq, adjdfe='satterthwaite', adjust="bon") # but is bonferroni best choice? realizing it is plotting ALL the comparisons...
print(mns)
mns=lsmeans(itpc_model, pairwise~prime_group|freq,adjdfe='satterthwaite', adjust="bon")
print(mns)

e1 <- allEffects(itpc_model)
print(e1)
plot(e1)


