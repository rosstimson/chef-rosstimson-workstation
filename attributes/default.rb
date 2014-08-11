# ==============================================================================
# rosstimson-vim customization

default['rosstimson-vim']['desktop']['enable'] = true

# Because this is computed it needs repeated here
if node['rosstimson-vim']['desktop']['enable']
  default['rosstimson-vim']['dependencies'] = %w( ncurses-devel gtk2-devel libX11-devel
                                                  libXt-devel ctags luajit-devel )
  default['rosstimson-vim']['configuration'] = "--with-features=huge \
                                                --prefix=#{default['rosstimson-vim']['prefix']} \
                                                --enable-gui \
                                                --with-tlib=ncurses \
                                                --enable-pythoninterp \
                                                --enable-multibyte \
                                                --enable-cscope \
                                                --enable-luainterp \
                                                --with-luajit \
                                                --disable-tclinterp \
                                                --disable-netbeans \
                                                --with-compiledby='Ross Timson <ross@rosstimson.com>'" # rubocop:disable LineLength
else
  default['rosstimson-vim']['dependencies'] = %w( ctags luajit-devel )
  default['rosstimson-vim']['configuration'] = "--with-features=huge \
                                                --prefix=#{default['rosstimson-vim']['prefix']} \
                                                --without-x \
                                                --with-tlib=ncurses \
                                                --enable-pythoninterp \
                                                --enable-multibyte \
                                                --enable-cscope \
                                                --enable-luainterp \
                                                --with-luajit \
                                                --disable-tclinterp \
                                                --disable-netbeans \
                                                --with-compiledby='Ross Timson <ross@rosstimson.com>'" # rubocop:disable LineLength
end
