# hflights and dplyr are both loaded and ready to serve you

# Write the 'piped' version of the English sentences.
hflights %>%
  mutate(diff = TaxiOut- TaxiIn) %>%
  filter(!is.na(diff) ) %>%
  summarize(avg =mean(diff))

# Chain together mutate(), filter() and summarize()
hflights %>%
  mutate(
    RealTime = ActualElapsedTime + 100, 
    mph = 60 * Distance / RealTime
  ) %>%
  filter(!is.na(mph), mph < 70) %>%
  summarize(
    n_less = n(), 
    n_dest = n_distinct(Dest), 
    min_dist = min(Distance), 
    max_dist = max(Distance)
  )

# Finish the command with a filter() and summarize() call
hflights %>%
  mutate(
    RealTime = ActualElapsedTime + 100, 
    mph = 60 * Distance / RealTime
  ) %>%
  filter(mph < 105 | Cancelled == 1 | Diverted == 1) %>%
  summarize(
    n_non = n(), 
    n_dest = n_distinct(Dest), 
    min_dist = min(Distance), 
    max_dist = max(Distance)
  )

# hflights is in the workspace as a tbl, with translated carrier names

# Make an ordered per-carrier summary of hflights
hflights %>%
  group_by(UniqueCarrier) %>%
  summarize(
    p_canc = 100* mean(Cancelled ==1),
    avg_delay = mean(ArrDelay, na.rm=TRUE)
  ) %>%
  arrange(avg_delay, p_canc)

# dplyr is loaded, hflights is loaded with translated carrier names

# Ordered overview of average arrival delays per carrier
hflights %>%
  filter(!is.na(ArrDelay) & ArrDelay > 0) %>%
  group_by(UniqueCarrier) %>%
  summarize(avg = mean(ArrDelay)) %>%
  mutate(rank = rank(avg)) %>%
  arrange(rank)


# dplyr and hflights (with translated carrier names) are pre-loaded

# How many airplanes only flew to one destination?
hflights %>%
  group_by(TailNum) %>%
  summarize(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarize(nplanes = n())

# Find the most visited destination for each carrier
hflights %>% 
  group_by(UniqueCarrier, Dest) %>%
  summarize(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)