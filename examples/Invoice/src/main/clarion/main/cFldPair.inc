!ABCIncludeFile(SV)

omit('End of include', _cFieldPairPresent_)
_cFieldPairPresent_        equate(1)



TFieldsPairGrp  group, type
LeftField         any
RightField        any
                end

TFieldsPairQ    queue(TFieldsPairGrp), type
                end


cFieldPair          class, type, module('cFldPair.clw'), link('cFldPair.clw', _svLinkMode_), DLL(_svDLLMode_)
FieldsPairQ           &TFieldsPairQ

Construct             procedure()
Destruct              procedure()
AddFields             procedure(*? pLeft, *? pRight), virtual
AssignLeftToRight     procedure(), virtual
AssignRightToLeft     procedure(), virtual
Equal                 procedure(), byte, virtual
                    end

  End of include
