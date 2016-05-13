#!/usr/bin/perl
#Скрипт на удаление очереди из команды postqueue -d 
#вписываем имя аккаунта

    $REGEXP = shift || die "no email-address given (regexp-style, e.g.bl.*\@yourdomain.com)!";

               @data = qx</usr/sbin/postqueue -p>;

          for (@data) {

               if (/^(\w+)(\*|\!)?\s/) {

                     $queue_id = $1;

            }

               if($queue_id) {

                  if (/$REGEXP/i) {

                    $Q{$queue_id} = 1;

                    $queue_id = "";

                }

              }

            }

           #open(POSTSUPER, "|cat") || die "нихуя не открылось postsuper" ;

            open(POSTSUPER, "|postsuper -d -") || die "нихуя не открылось postsuper" ;

            foreach (keys %Q) {

                   print POSTSUPER "$_\n";

             };
                 close(POSTSUPER);
