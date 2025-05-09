const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    retry_strategy: () => 1000 // Retry after 1 second if connection fails
});
const sub = redisClient.duplicate(); // Create a duplicate client for subscribing

function fib(index) {
    if (index < 2) return 1;
    return fib(index - 1) + fib(index - 2);
}

sub.on('message', (channel, message) => {
    redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe('insert'); // Subscribe to the 'insert' channel
// When a message is received on the 'insert' channel, calculate the Fibonacci number for the given index and store it in Redis