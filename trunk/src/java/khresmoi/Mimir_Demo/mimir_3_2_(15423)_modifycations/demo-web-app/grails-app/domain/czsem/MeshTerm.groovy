package czsem

class MeshTerm {
    String enTerm
    String czTerm
    String meshID

    
   static mapping = {
      enTerm index: 'enTerm_idx'
      czTerm index: 'czTerm_idx'
  }
    
}
