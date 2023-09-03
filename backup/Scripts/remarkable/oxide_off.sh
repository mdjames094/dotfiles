#!/bin/bash

ssh rmk <<-END
  systemctl disable --now tarnish 
  systemctl disable --now rm2fb 
  systemctl enable --now xochitl
  reboot
END

