CREATE OR REPLACE FUNCTION INT_CHANNEL_MESSAGE_NOTIFY_FCT()
    RETURNS TRIGGER AS
$BODY$
BEGIN
    PERFORM pg_notify('int_channel_message_notify', NEW.REGION || ' ' || NEW.GROUP_KEY);
    RETURN NEW;
END;
$BODY$
    LANGUAGE PLPGSQL;;

DROP TRIGGER IF EXISTS INT_CHANNEL_MESSAGE_NOTIFY_TRG ON INT_CHANNEL_MESSAGE;;

CREATE TRIGGER INT_CHANNEL_MESSAGE_NOTIFY_TRG
    AFTER INSERT ON INT_CHANNEL_MESSAGE
    FOR EACH ROW
EXECUTE PROCEDURE INT_CHANNEL_MESSAGE_NOTIFY_FCT();;