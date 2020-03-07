# Make qPCR Fragment WITH PLATES

Documentation here. Start with a paragraph, not a heading or title, as in most views, the title will be supplied by the view.
### Inputs


- **Forward Primer** [FP]  
  - <a href='#' onclick='easy_select("Sample Types", "Primer")'>Primer</a> / <a href='#' onclick='easy_select("Containers", "Primer Aliquot")'>Primer Aliquot</a>

- **Reverse Primer** [RP]  Part of collection
  - <a href='#' onclick='easy_select("Sample Types", "Primer")'>Primer</a> / <a href='#' onclick='easy_select("Containers", "96-Well Primer Aliquot Plate")'>96-Well Primer Aliquot Plate</a>

- **Template** [T]  
  - <a href='#' onclick='easy_select("Sample Types", "DNA Library")'>DNA Library</a> / <a href='#' onclick='easy_select("Containers", "Post-exonuclease")'>Post-exonuclease</a>
  - <a href='#' onclick='easy_select("Sample Types", "DNA Library")'>DNA Library</a> / <a href='#' onclick='easy_select("Containers", "Amplified Fragment Library")'>Amplified Fragment Library</a>

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
#  Make qPCR Fragment WITH PLATES

needs "Preparative qPCR/PreparativeqPCRHelper"

class Protocol

    include PreparativeqPCRHelper

    def main

        run_protocol

    end

end
```
