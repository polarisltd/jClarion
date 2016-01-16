#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#! Really don't understand the point of section, but here goes nothing...
#APPLICATION
#CREATE('tmp.$$$')
#SECTION
foo bar
#ENDSECTION
#CLOSE
baz
#APPEND('tmp.$$$')
#REMOVE('tmp.$$$')