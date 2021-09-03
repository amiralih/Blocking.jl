using Statistics
using Plots

"""
    blocking(x)

Estimate the error of the mean for correlated data `x`, using the method described in “Error estimates on averages of correlated data”, H. Flyvbjerg, H.G. Petersen, J. Chem. Phys. 91, 461 (1989).

# Examples
```julia-repl
julia> blocking(sin.(1:1000))
0.012596522451884442
```
"""
function blocking(x, plotting = false)
	
	n = length(x)
	d = convert(Int, floor(log2(n)))
	
	if (n < 8)
		println("Warning: Less than 8 data points.")
	end
	
	σ   = zeros(d)
	σ_e = zeros(d)
	y = x
	
	for i in 1:d
		c0 = var(y)
		σ[i]   = sqrt(c0 / (n - 1))
		σ_e[i] = σ[i] / sqrt(2(n - 1))
		# blocking transformation:
		y = (y[1:2:end-1] + y[2:2:end]) / 2
		n = length(y)
	end
	
	convergence = false
	index = d
	for i in 1:d-1
		if (σ[i+1] - σ_e[i+1]) < σ[i] < (σ[i+1] + σ_e[i+1])
			convergence = true
			index = i
			break
		end
	end
	
	if plotting
		p = plot(1:d, σ, yerr=σ_e)
		savefig(p, "plot.pdf")
	end
	
	if !convergence
		println("Warning: Convergence was not achieved.")
	end
	
	return σ[index]
end

