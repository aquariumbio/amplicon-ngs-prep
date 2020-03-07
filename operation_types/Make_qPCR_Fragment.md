# Make qPCR Fragment

Documentation here. Start with a paragraph, not a heading or title, as in most views, the title will be supplied by the view.
### Inputs


- **Forward Primer** [FP]  
  - <a href='#' onclick='easy_select("Sample Types", "Primer Mix")'>Primer Mix</a> / <a href='#' onclick='easy_select("Containers", "Primer Mix Stock")'>Primer Mix Stock</a>

- **Reverse Primer** [RP]  
  - <a href='#' onclick='easy_select("Sample Types", "Primer Mix")'>Primer Mix</a> / <a href='#' onclick='easy_select("Containers", "Primer Mix Stock")'>Primer Mix Stock</a>

- **Template** [T]  
  - <a href='#' onclick='easy_select("Sample Types", "DNA Library")'>DNA Library</a> / <a href='#' onclick='easy_select("Containers", "Post-exonuclease")'>Post-exonuclease</a>
  - <a href='#' onclick='easy_select("Sample Types", "DNA Library")'>DNA Library</a> / <a href='#' onclick='easy_select("Containers", "Amplified Fragment Library")'>Amplified Fragment Library</a>
  - <a href='#' onclick='easy_select("Sample Types", "DNA Library")'>DNA Library</a> / <a href='#' onclick='easy_select("Containers", "Library Stock")'>Library Stock</a>
  - <a href='#' onclick='easy_select("Sample Types", "Fragment")'>Fragment</a> / <a href='#' onclick='easy_select("Containers", "Fragment Stock")'>Fragment Stock</a>

### Parameters

- **Program** [qPCR1,qPCR2]

### Outputs


- **Fragment** [T]  Part of collection
  - <a href='#' onclick='easy_select("Sample Types", "DNA Library")'>DNA Library</a> / <a href='#' onclick='easy_select("Containers", "96 qPCR collection")'>96 qPCR collection</a>

### Precondition <a href='#' id='precondition'>[hide]</a>
```ruby
def precondition(_op)
  true
end
```

### Protocol Code <a href='#' id='protocol'>[hide]</a>
```ruby
# Make qPCR Fragment

needs "Preparative qPCR/PreparativeqPCRHelper"

class Protocol

    include PreparativeqPCRHelper

    def main

        run_protocol

    end

end
```
