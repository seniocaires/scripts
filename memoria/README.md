Iniciar um container
```{r, engine='bash', count_lines}
sudo docker -m 512M -it ubuntu /bin/bash
```

Instalar no container:
```{r, engine='bash', count_lines}
apt-get update && apt-get install -y build-essential
```

Criar arquivo memoria.c
```C
#include <stdlib.h>
#include <stdio.h>

int main(void) {
    int i;
    for (i=0; i<65536; i++) {
        char *q = malloc(65536);
        printf ("Alocado: %ld\n", 65536*i);
    }
    sleep(9999999);
}
```
Compilar:
```{r, engine='bash', count_lines}
gcc -o foo memoria.c
```
Abrir em um novo terminal:
```{r, engine='bash', count_lines}
cd /sys/fs/cgroup/memory/lxc/{{containerID}}
while true; do echo -n "Mem Uso (mb): " && expr `cat memory.usage_in_bytes` / 1024 / 1024; echo -n "Mem+swap Uso (mb): " && expr `cat memory.limit_in_bytes` / 1024 / 1024; sleep 1; done
```
ou
```{r, engine='bash', count_lines}
docker stats
```

Executar no container:
```{r, engine='bash', count_lines}
./foo
```

Usando LXC - não libcontainer
```{r, engine='bash', count_lines}
sudo docker run --lxc-conf="lxc.cgroup.memory.limit_in_bytes=512M" -it ubuntu /bin/bash
# Set total igual RAM (ex. sem usar swap)
sudo docker run --lxc-conf="lxc.cgroup.memory.max_usage_in_bytes=512M" --lxc-conf="lxc.cgroup.memory.limit_in_bytes=512M" -it ubuntu /bin/bash
```
