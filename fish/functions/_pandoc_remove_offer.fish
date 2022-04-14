function _pandoc_remove_offer
    for template in (ls -1 $PANDOC_DATA_DIR/templates/*.latex)
        echo (basename $template)
    end
end
