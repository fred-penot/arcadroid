<?php
namespace Arcadroid\Commands;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class LaunchGameCommand extends \Knp\Command\Command {

    private $host = '192.168.1.20';
    private $user = 'root';
    private $port = '22';
    private $password = 'recalboxroot';
    private $con = null;
    private $shell_type = 'xterm';
    private $shell = null;
    private $log = '';

    protected function configure() {
        $this->setName("launch:game")->setDescription(
            "Lance un jeu sur recallbox.");
    }

    protected function execute(InputInterface $input, OutputInterface $output) {
        try {
            ini_set('memory_limit', '512M');
            $app = $this->getSilexApplication();
            $msg = "Lancement du jeu sur recallbox";
            $app['monolog.game']->addInfo($msg);
            //$this->connectRecalbox($output);
            $this->launch($output);
            //$this->con  = null;
            $output->writeln($msg);
        } catch (\Exception $ex) {
            $app['monolog.game']->addError($ex->getMessage());
            $output->writeln("Une erreur s'est produite : " . $ex->getMessage());
        }
    }

    private function launch(OutputInterface $output) {
        $this->con  = ssh2_connect($this->host, $this->port);
        if( !$this->con ) {
            $output->writeln("Connection failed !");
        } else {
            $output->writeln("Connection done !");
            if( !ssh2_auth_password( $this->con, $this->user, $this->password ) ) {
                $output->writeln("Authorization failed !");
            } else {
                $output->writeln("Authorization done !");
                $cmd = '/recalbox/scripts/runcommand.sh 4 "retroarch -L /usr/lib/libretro/pcsx_rearmed_libretro.so --config /recalbox/configs/retroarch/retroarchcustom.cfg /recalbox/share/roms/psx/Tekken_3_Track_1.bin"';
                $streamLaunch = ssh2_exec( $this->con, $cmd );
                if( !$streamLaunch ) {
                    $output->writeln("Impossible de lancer la commande !");
                }
                stream_set_blocking($streamLaunch, true);
                $streamLines = stream_get_contents($streamLaunch);
                //$output->writeln($streamLines);
            }
        }
    }

    private function connectRecalbox(OutputInterface $output) {
        $this->con  = ssh2_connect($this->host, $this->port);
        if( !$this->con ) {
            $output->writeln("Connection failed !");
        } else {
            $output->writeln("Connection done !");
            if( !ssh2_auth_password( $this->con, $this->user, $this->password ) ) {
                $output->writeln("Authorization failed !");
            } else {
                $output->writeln("Authorization done !");
                $cmd = 'ps -ef | grep retroarch';
                $streamLaunch = ssh2_exec( $this->con, $cmd );
                if( !$streamLaunch ) {
                    $output->writeln("Impossible de lancer la commande !");
                } else {
                    $pid = null;
                    stream_set_blocking($streamLaunch, true);
                    $streamLines = stream_get_contents($streamLaunch);
                    $lines = explode("\n", $streamLines);
                    foreach ($lines as $line){
                        $pos = strrpos($line, 'runcommand.sh');
                        if ($pos === false) {
                            $field = explode(" ", $line);
                            if (!$pid){
                                $pid = $field[0];
                                if ($pid == '') {
                                    $pid = $field[1];
                                }
                            }
                        }
                    }
                    $output->writeln("pid =>> ". $pid);
                    //$this->stop($pid, $output);
                }
            }
        }
    }

    private function stop($pid, OutputInterface $output)
    {
        $cmd = 'kill '.$pid;
        $streamKill = ssh2_exec($this->con, $cmd);
        if (!$streamKill) {
            $output->writeln("Impossible de tuer le processus !");
        }
    }
}