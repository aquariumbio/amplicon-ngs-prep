var config = {

  tagline: "The Laboratory</br>Operating System",
  documentation_url: "http://localhost:4000/aquarium",
  title: "Aquarium Amplicon NGS Prep",
  navigation: [

    {
      category: "Overview",
      contents: [
        { name: "Introduction", type: "local-md", path: "README.md" },
        { name: "About this Workflow", type: "local-md", path: "ABOUT.md" },
        { name: "License", type: "local-md", path: "LICENSE.md" },
        { name: "Issues", type: "external-link", path: 'https://github.com/dvnstrcklnd/aq-amplicon-ngs-prep/issues' }
      ]
    },

    

      {

        category: "Operation Types",

        contents: [

          
            {
              name: 'Digest Genomic DNA',
              path: 'operation_types/Digest_Genomic_DNA' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Dilute to 4nM',
              path: 'operation_types/Dilute_to_4nM' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Extract Gel Slice (NGS)',
              path: 'operation_types/Extract_Gel_Slice_NGS_' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Make qPCR Fragment',
              path: 'operation_types/Make_qPCR_Fragment' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Make qPCR Fragment WITH PLATES',
              path: 'operation_types/Make_qPCR_Fragment_WITH_PLATES' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Pour Gels',
              path: 'operation_types/Pour_Gels' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Purify Gel Slice (NGS)',
              path: 'operation_types/Purify_Gel_Slice_NGS_' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Qubit concentration',
              path: 'operation_types/Qubit_concentration' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Run Pre-poured Gel',
              path: 'operation_types/Run_Pre-poured_Gel' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Treat With Zymolyase',
              path: 'operation_types/Treat_With_Zymolyase' + '.md',
              type: "local-md"
            },
          
            {
              name: 'Yeast Plasmid Extraction',
              path: 'operation_types/Yeast_Plasmid_Extraction' + '.md',
              type: "local-md"
            },
          

        ]

      },

    

    

      {

        category: "Libraries",

        contents: [

          
            {
              name: 'CollectionDisplay',
              path: 'libraries/CollectionDisplay' + '.html',
              type: "local-webpage"
            },
          
            {
              name: 'DNAGel',
              path: 'libraries/DNAGel' + '.html',
              type: "local-webpage"
            },
          
            {
              name: 'FragmentLibrary',
              path: 'libraries/FragmentLibrary' + '.html',
              type: "local-webpage"
            },
          
            {
              name: 'NextGenPrepHelper',
              path: 'libraries/NextGenPrepHelper' + '.html',
              type: "local-webpage"
            },
          
            {
              name: 'PreparativeqPCRHelper',
              path: 'libraries/PreparativeqPCRHelper' + '.html',
              type: "local-webpage"
            },
          
            {
              name: 'PurificationHelper',
              path: 'libraries/PurificationHelper' + '.html',
              type: "local-webpage"
            },
          
            {
              name: 'YeastDisplayHelper',
              path: 'libraries/YeastDisplayHelper' + '.html',
              type: "local-webpage"
            },
          
            {
              name: 'YeastDisplayShows',
              path: 'libraries/YeastDisplayShows' + '.html',
              type: "local-webpage"
            },
          

        ]

    },

    

    
      { category: "Sample Types",
        contents: [
          
            {
              name: 'DNA Library',
              path: 'sample_types/DNA_Library'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'E coli strain',
              path: 'sample_types/E_coli_strain'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Fragment',
              path: 'sample_types/Fragment'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Oligo Pool',
              path: 'sample_types/Oligo_Pool'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Plasmid',
              path: 'sample_types/Plasmid'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Primer',
              path: 'sample_types/Primer'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Primer Mix',
              path: 'sample_types/Primer_Mix'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Yeast Strain',
              path: 'sample_types/Yeast_Strain'  + '.md',
              type: "local-md"
            },
          
        ]
      },
      { category: "Containers",
        contents: [
          
            {
              name: '50 mL 0.8 Percent Agarose Gel in Gel Box',
              path: 'object_types/50_mL_0.8_Percent_Agarose_Gel_in_Gel_Box'  + '.md',
              type: "local-md"
            },
          
            {
              name: '50 mL Agarose Gel in Gel Box',
              path: 'object_types/50_mL_Agarose_Gel_in_Gel_Box'  + '.md',
              type: "local-md"
            },
          
            {
              name: '96 qPCR collection',
              path: 'object_types/96_qPCR_collection'  + '.md',
              type: "local-md"
            },
          
            {
              name: '96-Well Primer Aliquot Plate',
              path: 'object_types/96-Well_Primer_Aliquot_Plate'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Amplified Fragment Library',
              path: 'object_types/Amplified_Fragment_Library'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Fragment Stock',
              path: 'object_types/Fragment_Stock'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Gel Slice',
              path: 'object_types/Gel_Slice'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Illuminated Fragment Library',
              path: 'object_types/Illuminated_Fragment_Library'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Library Gel Slice',
              path: 'object_types/Library_Gel_Slice'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Library Stock',
              path: 'object_types/Library_Stock'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Plasmid Library',
              path: 'object_types/Plasmid_Library'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Post-exonuclease',
              path: 'object_types/Post-exonuclease'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Primer Aliquot',
              path: 'object_types/Primer_Aliquot'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Primer Mix Stock',
              path: 'object_types/Primer_Mix_Stock'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Yeast Library in Soln 1',
              path: 'object_types/Yeast_Library_in_Soln_1'  + '.md',
              type: "local-md"
            },
          
            {
              name: 'Zymolyased Yeast Library',
              path: 'object_types/Zymolyased_Yeast_Library'  + '.md',
              type: "local-md"
            },
          
        ]
      }
    

  ]

};
