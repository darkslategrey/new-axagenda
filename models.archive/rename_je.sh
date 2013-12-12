for i in je_cat* ; do cp $i $(echo $i | sed 's,^je_\(.*\),../models/\1,'); done

