
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

void* hwthread(void* vargp);

int main(int argc, char* argv[]) {
    printf("Starting.\n");

    pthread_t thr_id;
    pthread_create(&thr_id, NULL, hwthread, NULL);

    printf("Hello world from main.\n");

    pthread_join(thr_id, NULL);

    printf("Ending.\n");

    return 0;
}

void* hwthread(void* vargp) {
    sleep(1);
    printf("Hello world from thread.\n");
    return NULL;
}
