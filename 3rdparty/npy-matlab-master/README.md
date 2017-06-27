# npy-matlab

Experimental code to read/write NumPy .NPY files in MATLAB


## Usage example:
```
>> a = rand(5,4,3);
>> writeNPY(a, 'a.npy');
>> b = readNPY('a.npy');
>> sum(a(:)==b(:))
ans =

    60
```

## Source

[kwikteam](https://github.com/kwikteam/npy-matlab/blob/master/readNPY.m)
