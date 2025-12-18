******************************** Uploading Useful Batch Files ****************************************
### stress.bat -> batch file for stress testing
### hacker.bat -> batch file for Hacker Cup (Take I/P and cpp file -> gives O/P)
*************************************************************************************

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

2. **srand( )** - used to change seed in rand( ) -> <mark> preferred to use current time as dynamic seed </mark>
   - srand( ) is called only once at the beginning of program
   - If we don't call srand( ) before rand( ) -> same as calling srand(1) automatically
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
          > Similar to creating instace of vector named ```arr```
           ```cpp
              vector<int> arr(100, -1)
       - chrono::steady_clock::now( ) --> Returns current time
       - time_since_epoch( ) --> Returns time elapsed since the epoch (January 1, 1970)
       - count( ) --> Converts duration into count of number of clock ticks since the epoch
       - (uint32_t) --> typecast result to unsigned 32-bit integer, which is used as seed for mt19937
       - **NOTE - time(0) provides low-resolution time (in seconds) because based on system's wall clock. But ```chrono library``` provides high-resolution time (in nanoseconds)**
        <br>
        
     - ```cpp
       int random_number = uniform_int_distribution<long long int>(70, MOD1 - 1)(rng)
       ```
       - creates distribution object that generates random integers uniformly distributed within the range `[70, MOD1 - 1]`
       - long long int parameter specifies the type that distribution will produce --> further narrowed down to range `[70, MOD - 1]`
       - Uniform Distribution ensures that each integer in the range has equal probability of being selected --> NO bias
       - rng is used to generate random number that is then mapped to the specified range by distribution
         
## Other relevant libraries or functions
1. time( ) - returns the number of seconds that have passed since the Unix Epoch (00:00:00 UTC, January 1, 1970)
   - requires exactly one argument -> cannot call without any parameter -> time( ) ❌
      - time(ptr) where ptr is pointer to a time_t variable to store the result
      - time(nullptr) = time(NULL) = time(0) ✅ -> only returns value; don't store it in any extra variable
           - NULL is a macro (usually defined as 0) -> less type-safe than nullptr bcz can be confused as integer
           - In C and older C++, the integer 0 is allowed to act as null pointer -> time(0) = time(nullptr)
           - Best pratice --> use nullptr
   - returns a value of type time_t --> since time is measured in whole seconds -> using double will be unnecessary + precision errors
      - Hence, time_t is int type --> all modern C++ compilers use 64-bit integer
