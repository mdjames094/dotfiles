#!/bin/bash

ssh rmk <<-END
  systemctl disable --now xochitl 
  systemctl enable --now rm2fb 
  systemctl enable --now tarnish
END

