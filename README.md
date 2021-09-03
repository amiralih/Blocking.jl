# Blocking.jl

Estimate the error of the mean for correlated data, using the method described in “Error estimates on averages of correlated data”, H. Flyvbjerg, H.G. Petersen, J. Chem. Phys. 91, 461 (1989).

## Example

```julia-repl
julia> blocking(sin.(1:1000))
0.012596522451884442
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
