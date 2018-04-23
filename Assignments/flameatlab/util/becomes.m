function varargout = becomes( varargin )
% Simultaneous assignment

assert( nargout == nargin, ...
    'number of input and output arguments must match' );

for i=1:nargout
    varargout{i} = varargin{i};
end

end

