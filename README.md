# Stress-Testing

## Pseudo-Random Number Generator (PRNG)
- Initial value which is used to start the sequence is called `seed`
- PRNG is the algorithm that produces sequence of random numbers but are not truly random as they can be determined if algorithm and seed are known.
- Faster and more efficient than true random number generators
- Same sequence can be generated again if seed is known -> useful for testing and debugging

## Some ways to generate random numbers
1. **rand( )** - Generate integers in the range `[0, RAND_MAX]` where RAND_MAX is implementation-dependent
   - To generate random numbers in range [a, b]
     ```cpp
     {a + rand() % (b-a+1)}

2. **srand( )** - used to change seed in rand( ) with current time as the dynamic seed
     ```cpp
     srand(time(0))
     
4. **mt19937 (Mersenne Twister)** - Generates high-quality random numbers that have better statistical randomness compared to rand( )
     - `period` is number of unique values PRNG can produce before repeating
         - Complex algorithms tend to have longer periods
         - Short period leads to predictable patterns and repetition
           
     - mt19937 has very large period of 2<sup>19937</sup> - 1 which is a Mersenne prime
       ```cpp
       mt19937 rng((uint32_t)chrono::steady_clock::now().time_since_epoch().count());
       ```
       - declared an instance of mt19937 named rng
       - chrono::steady_clock::now() --> Returns current time
       - time_since_epoch() --> Returns time elapsed since the epoch (January 1, 1970)
       - count() --> Converts duration into count of number of clock ticks since the epoch
       - (uint32_t) --> typecast result to unsigned 32-bit integer, which is used as seed for mt19937
        <br>
        
     - ```cpp
       int random_number = uniform_int_distribution<long long int>(70, MOD1 - 1)(rng)
       ```
       - creates distribution object that generates random integers uniformly distributed within the range `[70, MOD1 - 1]`
       - long long int parameter specifies the type that distribution will produce --> further narrowed down to range `[70, MOD - 1]`
       - Uniform Distribution ensures that each integer in the range has equal probability of being selected --> NO bias
       - rng is used to generate random number that is then mapped to the specified range by distribution
